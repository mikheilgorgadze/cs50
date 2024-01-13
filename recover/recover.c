#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define BUF_SIZE 512
int main(int argc, char *argv[])
{
    if (argc != 2) {
        printf("Usage: ./recover [image]");
    } 

    FILE *card = fopen(argv[1], "r");

    uint8_t buffer[BUF_SIZE];

    while (fread(buffer, 1, 512, card) == 512) {
        
    }
}
