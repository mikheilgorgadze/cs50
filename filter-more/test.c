#include <stdio.h>

void intToHex(int num) {
    printf("Decimal: %d\n", num);
    printf("Hexadecimal: 0x%X\n", num);
}

int main() {
    int number;

    printf("Enter an integer: ");
    scanf("%d", &number);

    intToHex(number);

    return 0;
}

