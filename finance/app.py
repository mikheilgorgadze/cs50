import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")


def user_balance(user_id):
    user = db.execute("select * from users u where u.id = ?", user_id)
    user_operations = db.execute("""
                            select sum(t.amount) total_amount, t.oper_type 
                             from transactions t 
                            where t.user_id = ?
                            group by t.oper_type
                            """, user_id)
    credit_operations = 0
    debit_operations = 0

    if len(user_operations) >= 1:
        for operation in user_operations:
            if operation["oper_type"] == "CREDIT":
                credit_operations = operation["total_amount"]
                continue
            elif operation["oper_type"] == "DEBIT":
                debit_operations = operation["total_amount"]
                continue
    current_cash = user[0]["cash"]
    return current_cash - debit_operations + credit_operations


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    user_id = session.get("user_id")
    stocks = db.execute("""select sum(case b.oper_type when 'DEBIT' then b.stock_sum
                                                            else -b.stock_sum
                                                            end) stock_count,
                                        b.stock_symbol
                                from (select t.stock_symbol, t.oper_type, sum(t.single_stock_count) stock_sum 
                                        from transactions t
                                       where t.user_id = ? 
                                       group by t.stock_symbol, t.oper_type) b
                                group by b.stock_symbol
                                having stock_count > 0
                        """, user_id)
    stocks_list = []
    total_stocks_value = 0
    for stock in stocks:
        print(stock["stock_symbol"])
        stock_info = {}
        lkp = lookup(stock["stock_symbol"])
        price = lkp["price"]
        stock_info["stock_name"] = stock["stock_symbol"]
        total_stocks_value += price * stock["stock_count"]
        stock_info["single_stock_price"] = price
        stock_info["share_count"] = stock["stock_count"]
        stock_info["total_stock_price"] = round(price * stock["stock_count"], 4)
        stocks_list.append(stock_info)

    current_cash_balance = round(user_balance(user_id), 4)
    total_stocks_value = round(total_stocks_value, 4)
    grand_total = round(current_cash_balance + total_stocks_value, 4)
    return render_template("index.html", stocks=stocks_list, current_cash_balance=current_cash_balance
                           , total_stocks_value=total_stocks_value, grand_total=grand_total)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "GET":
        return render_template("buy.html")

    if request.method == "POST":
        if not request.form.get("symbol") or not request.form.get("shares"):
            return apology("You should fill both stock to buy and number of stocks")

        stock_lookup = lookup(request.form.get("symbol"))

        if not stock_lookup:
            return apology("Enter correct stock symbol")

        try:
            shares = int(request.form.get("shares"))
        except ValueError:
            return apology("Number of stocks value should be a numeric value")

        user_id = session.get("user_id")
        user = db.execute("select * from users u where u.id = ?", user_id)

        single_stock_price = stock_lookup["price"]
        total_price = shares * single_stock_price

        user_current_balance = user_balance(user_id)

        if total_price > user_current_balance:
            return apology("Not enough cash")
        else:
            db.execute("""
                        insert into transactions (user_id,  amount, stock_symbol, single_stock_price, 
                        single_stock_count, oper_type) 
                        values (?, ?, ?, ?, ?, ?)
                    """, user_id, total_price, stock_lookup["symbol"], single_stock_price, shares, "DEBIT")
    return redirect("/")


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    user_id = session.get("user_id")
    transaction_hist = db.execute("""select * from transactions_v v where v.user_id = ?""", user_id)

    return render_template("history.html", transaction_hist=transaction_hist)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute(
            "SELECT * FROM users WHERE username = ?", request.form.get("username")
        )

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(
                rows[0]["hash"], request.form.get("password")
        ):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "GET":
        return render_template("quote.html")
    elif request.method == "POST":
        quotes = lookup(request.form.get("symbol"))
        if not quotes:
            return apology("You should pass quote value")

        return render_template("quoted.html", quotes=quotes)
    return apology("TODO")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method == "GET":
        return render_template("register.html")
    elif request.method == "POST":
        username = request.form.get("username")
        if not username:
            return apology("No username passed")
        users = db.execute("SELECT * FROM users u WHERE u.username = ?", username)
        if len(users) == 1:
            return apology("Username already exists")

        password1 = request.form.get("password1")
        password2 = request.form.get("password2")
        if not password1 or not password2:
            return apology("Password not passed")
        elif password1 != password2:
            return apology("Passwords do not match")
        elif len(password1) < 8 or len(password2) < 8:
            return apology("Password length should be at least 8 characters")
        else:
            db.execute("INSERT INTO users (username, hash) VALUES(?, ?)", username, generate_password_hash(password1))

    return redirect("/")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    user_id = session.get("user_id")
    user_stock_query = db.execute("""select sum(t.single_stock_count) stock_count, t.stock_symbol 
                                       from transactions t 
                                      where t.user_id = ?
                                      group by  t.stock_symbol
                                """, user_id)
    user_stock_query_len = len(user_stock_query)
    if request.method == "GET":
        stock_list = []
        if user_stock_query_len >= 1:
            for query in user_stock_query:
                stock_list.append(query["stock_symbol"])
        else:
            return apology("You do not own any stock")

        return render_template("sell.html", stock_list=stock_list)
    elif request.method == "POST":
        user_chosen_share_count = request.form.get("shares")
        user_chosen_stock_symbol = request.form.get("symbol")
        lkp = lookup(user_chosen_stock_symbol)
        single_stock_price = lkp["price"]
        if not user_chosen_share_count:
            return apology("You should input number of shares")

        try:
            user_chosen_share_count = int(user_chosen_share_count)
        except ValueError:
            return apology("Share count should be numeric value")

        if user_chosen_share_count < 1:
            return apology("Number of shares should be a positive integer")

        amount = user_chosen_share_count * single_stock_price
        for query in user_stock_query:
            if query["stock_symbol"] == user_chosen_stock_symbol and not query["stock_count"]:
                return apology("You do not own any shares of this stock")
            elif query["stock_symbol"] == user_chosen_stock_symbol and query["stock_count"] < user_chosen_share_count:
                return apology("You do not own that many shares of this stock")

        db.execute("""insert into transactions
                      (user_id, amount, stock_symbol, single_stock_price, single_stock_count, oper_type)
                      values(?, ?, ?, ?, ?, ?)
                      """, user_id, amount, user_chosen_stock_symbol, single_stock_price, user_chosen_share_count
                   , "CREDIT")

    return redirect("/")
