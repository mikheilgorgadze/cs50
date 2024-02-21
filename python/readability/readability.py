from cs50 import get_string


def count_letters(txt):
    letter_count = 0
    for i in txt:
        if str(i).isalpha():
            letter_count += 1

    return letter_count


def count_words(txt):
    words = str(txt).split()
    word_count = len(words)

    return word_count


def count_sentences(txt):
    sentence_count = 0

    for i in txt:
        if i == "." or i == "!" or i == "?":
            sentence_count += 1

    return sentence_count


text = get_string("Text: ")

L = 100 * count_letters(text) / count_words(text)
S = 100 * count_sentences(text) / count_words(text)
index = round(0.0588 * L - 0.296 * S - 15.8)

if index >= 16:
    print("Grade 16+")
elif index < 1:
    print("Before Grade 1")
else:
    print(f"Grade {index}")
