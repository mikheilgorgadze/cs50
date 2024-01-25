from cs50 import get_int
import math


def digit_sum(n):
    d_sum = 0

    for i in range(len(str(n))):
        divisor = pow(10, i)
        dividend = math.floor(n / divisor)
        digit = dividend % 10
        d_sum += digit

    return d_sum


def luhns_algorithm(n):
    card_sum = 0
    other_sum = 0

    for i in range(1, len(str(n)), 2):
        divisor = pow(10, i)
        dividend = math.floor(n / divisor)
        double_digit = 2 * (dividend % 10)
        card_sum += digit_sum(double_digit)

    for i in range(0, len(str(n)), 2):
        divisor = pow(10, i)
        dividend = math.floor(n / divisor)
        digit = dividend % 10
        other_sum += digit_sum(digit)

    total_sum = card_sum + other_sum
    if total_sum % 10 == 0:
        return True
    else:
        return False


def nth_digit(n, x):
    return math.floor(n / pow(10, len(str(n)) - x))


card_number = get_int("Enter a card number: ")
mc_numbers = [51, 52, 53, 54, 55]
amex_numbers = [37, 34]

if luhns_algorithm(card_number):
    if (len(str(card_number)) == 13 or len(str(card_number)) == 16) and nth_digit(card_number, 1) == 4:
        print("VISA")
    elif len(str(card_number)) == 16 and nth_digit(card_number, 2) in mc_numbers:
        print("MASTERCARD")
    elif len(str(card_number)) == 15 and nth_digit(card_number, 2) in amex_numbers:
        print("AMEX")
    else:
        print("INVALID")
else:
    print("INVALID")
