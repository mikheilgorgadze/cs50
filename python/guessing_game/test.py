from guess_number import solve_guess_the_number
from random import randint


def main():
    max_int = 1000000
    secret_number = randint(1, max_int)
    guess_count = solve_guess_the_number(1, max_int, secret_number)

    print(f"Total guess count is: {guess_count}")


def powers_of_ten(limit):
    powers = []
    min_power = 1
    while min_power <= limit:
        powers.append(min_power)
        min_power *= 10
    return powers


if __name__ == "__main__":
    main()
