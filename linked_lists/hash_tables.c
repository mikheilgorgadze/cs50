#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#define TABLE_SIZE 7 

typedef struct Pair{
    int values;
    char* symbols;
} Pair;

typedef struct HashTable {
    int size;
    Pair *table;
} HashTable;

HashTable* initializeHashTable(){
    HashTable *hashTable = (HashTable* )malloc(sizeof(HashTable));
    hashTable->size = 13;
    hashTable->table = (Pair* )malloc(sizeof(Pair) * hashTable->size);

    hashTable->table[0] = (Pair){1000, "M"};
    hashTable->table[1] = (Pair){900, "CM"};
    hashTable->table[2] = (Pair){500, "D"};
    hashTable->table[3] = (Pair){400, "CD"};
    hashTable->table[4] = (Pair){100, "C"};
    hashTable->table[5] = (Pair){90, "XC"};
    hashTable->table[6] = (Pair){50, "L"};
    hashTable->table[7] = (Pair){40, "XL"};
    hashTable->table[8] = (Pair){10, "X"};
    hashTable->table[9] = (Pair){9, "IX"};
    hashTable->table[10] = (Pair){5, "V"};
    hashTable->table[11] = (Pair){4, "IV"};
    hashTable->table[12] = (Pair){1, "I"};

    return hashTable;
}

char* intToRoman(int num) {
    HashTable *hashtable = initializeHashTable();


    char* result = (char*)malloc(sizeof(char) * 20); 

    int i, index = 0;
    for (i = 0; i < hashtable->size; i++){
        while(num >= hashtable->table[i].values){
            int len = strlen(hashtable->table[i].symbols);
            strncpy(result + index, hashtable->table[i].symbols, len);
            index += len;

            num -= hashtable->table[i].values;
        }
    }
    result[index] = '\0';
    free(hashtable->table);
    free(hashtable);

    return result;
}
int main(){ 
    int num = 1994;

    char* romanNumeral = intToRoman(num);

    printf("%s\n", romanNumeral);
    
    return 0;
}
