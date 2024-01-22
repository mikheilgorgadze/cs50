// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "dictionary.h"

// TODO: Choose number of buckets in hash table
#define N 26

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
} node;

// Hash table
node *table[N];

void init_table()
{
    for (int i = 0; i < N; i++)
    {
        table[i] = NULL;
    }
}

bool insert_into_table(node *n)
{
    if (n == NULL)
        return false;

    int index = hash(n->word);
    if (table[index] != NULL)
    {
        n->next = table[index];
    }

    table[index] = n;
    return true;
}
void print_table()
{
    for (int i = 0; i < N; i++)
    {
        if (table[i] == NULL)
        {
            printf("\t%i\t----\n", i);
        }
        else
        {
            printf("\t%i\t%s\n", i, table[i]->word);
        }
    }
}

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    int index = hash(word);
    if (table[index] == NULL)
    {
        return false;
    }
    return true;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    int length = strlen(word);
    unsigned int hash_val = 0;
    for (int i = 0; i < length; i++)
    {
        hash_val += word[i];
        hash_val = (hash_val * word[i]) % N;
    }

    return hash_val;
    // return (toupper(word[0]) - 'A') % N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO
    init_table();

    FILE *source = fopen(dictionary, "r");
    if (source == NULL)
    {
        return false;
    }

    char dict_word[LENGTH + 1];
    while (fscanf(source, "%s", dict_word) == 1)
    {
        node *word_node = (node *)(malloc(sizeof(node)));
        if (word_node == NULL)
        {
            fclose(source);
            unload();
            return false; // Handle memory allocation failure
        }
        strcpy(word_node->word, dict_word);
        word_node->next = NULL;
        insert_into_table(word_node);
    };

    print_table();
    fclose(source);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    return 0;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    for (int i = 0; i < N; i++)
    {
        node *current = table[i];
        while (current != NULL)
        {
            node *temp = current;
            current = current->next;
            free(temp);
        }
    }
    return true;
}
