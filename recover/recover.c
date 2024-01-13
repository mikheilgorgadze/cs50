#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define BUF_SIZE 512
int main(int argc, char *argv[])
{
    if (argc != 2) {
        printf("Usage: ./recover [image]\n");
        return 1;
    } 

    FILE *card = fopen(argv[1], "r");
    if (card == NULL) {
        printf("Card can not be opened\n");
        return 1;
    }

    uint8_t buffer[BUF_SIZE];
    char *filename = malloc(8 * sizeof(char));
    int filename_count = 0;
    while (fread(buffer, 1, 512, card) == 512) {
        //split card file into jpeg's and output them as ###.jpg (from 000 to upwards)  
        if (buffer[0]==0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0) {
            sprintf(filename, "%03i.jpg", filename_count);
            if (filename_count == 0) {
                FILE *img =  fopen(filename, "w");

                fwrite(buffer, 1, 512, img);
                filename_count ++;
                fclose(img);
            } else {
                FILE *img = fopen(filename, "w");   
                fwrite(buffer, 1, 512, img);
                filename_count ++;
                fclose(img);
            }

        } else if (filename_count > 0){
            FILE *img = fopen(filename, "a");
            fwrite(buffer, 1, 512, img);
            fclose(img);
        } 
    }
    
    
    fclose(card);
    free(filename);
}
