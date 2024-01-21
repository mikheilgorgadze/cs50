#include <stdio.h>
#include <stdlib.h>


typedef struct List{
    int num;
    struct List *next;
} List;


List* create(int num) {
    List* new_node = malloc(sizeof(List));
    if (new_node == NULL) {
        exit(1);
    }

    new_node->num = num;
    new_node->next = NULL;


    return new_node;
}

List* insert(List* head, int num) {
    List* new_node = malloc(sizeof(List));
    if (new_node == NULL) {
        exit(1);
    }
    new_node->num = num;
    new_node->next = head;

    head = new_node;
    return head;
}

void free_list(List* head) {
    if (head == NULL) {
        return;
    } 
    List *nextNode = head->next;
    free_list(nextNode);
    free(head);
}

int main(int argc, char* argv[]) {
    
    List *nums = NULL;

    for (int i = 0; i < argc; i++) {
        if (i == 0) {
           nums = create(atoi(argv[i]));
           continue;
        }
        int number = atoi(argv[i]);
        nums = insert(nums, number);
    }

    List *ptr = nums;

    while (ptr != NULL) {
        printf("int in list is: %i\n", ptr->num);
        ptr = ptr->next;
    }

    free_list(nums);

    return 0;
}
