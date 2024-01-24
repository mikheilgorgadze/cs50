#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LENGTH 45

char *convert_to_lower(const char *word) {
    char *lower_word = (char *)malloc(LENGTH + 1);

    if (lower_word == NULL) {
        return NULL;
    }

    for (int i = 0; i < strlen(word); i++) {
        lower_word[i] += tolower(word[i]);
    }

    lower_word[strlen(word)] = '\0';

    return lower_word;
}

int main(void) {
    char *test_word = "HelloO";
    char *test_word2 = "helloo";
    char *lwr_test_word = convert_to_lower(test_word);

    printf("%s\n", lwr_test_word);
    strcmp(test_word, test_word2) == 0 ? printf("test_word is equal to test_word2\n") : printf("test_word is not equal to test_word2\n");
    free(lwr_test_word);
}