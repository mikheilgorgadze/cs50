import math
from enum import Enum


class GuessResults(Enum):
    CORRECT = 0
    LESS = 1
    GREATER = 2


def prompt_user():
    guess = input("Enter your guess: ")
    while not guess.isdigit():
        print("Enter valid number")
        guess = input("Enter your guess: ")

    return int(guess)


def guess_the_number(answer, hidden_num, user_prompt):
    if hidden_num == answer:
        if user_prompt:
            print("You win")
        return GuessResults.CORRECT
    else:
        if user_prompt:
            print("Wrong guess")
        if answer < hidden_num:
            if user_prompt:
                print("Too little")
            return GuessResults.LESS
        else:
            if user_prompt:
                print("Too big")
            return GuessResults.GREATER


def solve_guess_the_number(min_rand_int, max_rand_int, secret_number, user_prompt=False):
    guess = prompt_user() if user_prompt else math.trunc((min_rand_int + max_rand_int) / 2)
    guess_count = 0

    while True:
        guess_result = guess_the_number(guess, secret_number, user_prompt)
        guess_count += 1
        if guess_result == GuessResults.CORRECT:
            break
        elif guess_result == GuessResults.LESS:
            min_rand_int = guess
            guess = prompt_user() if user_prompt else math.trunc((min_rand_int + max_rand_int) / 2)
        else:
            max_rand_int = guess
            guess = prompt_user() if user_prompt else math.trunc((min_rand_int + max_rand_int) / 2)

    return guess_count
