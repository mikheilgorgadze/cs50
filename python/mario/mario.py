from cs50 import get_int


def draw_pyramid(h):
    for i in range(1, h + 1):
        # print left side of a pyramid
        for k in range(h, i, -1):
            print(" ", end="")

        # print a brick
        for j in range(i):
            print("#", end="")

        # print middle of a pyramid
        print("  ", end="")

        # print right side of a pyramid
        for t in range(i):
            print("#", end="")

        print()


height = 0
while height < 1 or height > 8:
    height = get_int("Height: ")

draw_pyramid(height)
