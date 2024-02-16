import math
import random
from enum import Enum


class GuessResults(Enum):
    CORRECT = 0
    LESS = 1
    GREATER = 2


MIN_INT = 1
MAX_INT = 10000000000000


def main():
    secret_number = random.randint(MIN_INT, MAX_INT)
    guess_count = solve_guess_the_number(MIN_INT, MAX_INT, secret_number)
    print(f"total number of guesses were {guess_count}")


def prompt_user():
    guess = input("Enter your guess: ")
    while not guess.isdigit():
        print("Enter valid number")
        guess = input("Enter your guess: ")

    return int(guess)


def guess_the_number(answer, hidden_num):
    if hidden_num == answer:
        # print("You win")
        return GuessResults.CORRECT
    else:
        # print("Wrong guess")
        if answer < hidden_num:
            # print("Too little")
            return GuessResults.LESS
        else:
            # print("Too big")
            return GuessResults.GREATER


def solve_guess_the_number(min_rand_int, max_rand_int, secret_number):
    guess = math.trunc((min_rand_int + max_rand_int) / 2)
    guess_count = 0

    while True:
        guess_result = guess_the_number(guess, secret_number)
        guess_count += 1
        if guess_result == GuessResults.CORRECT:
            break
        elif guess_result == GuessResults.LESS:
            min_rand_int = guess
            guess = math.trunc((min_rand_int + max_rand_int) / 2)
        else:
            max_rand_int = guess
            guess = math.trunc((min_rand_int + max_rand_int) / 2)

    return guess_count


if __name__ == "__main__":
    main()
