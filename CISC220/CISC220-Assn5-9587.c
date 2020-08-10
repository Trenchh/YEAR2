//  Ryan Protheroe
//  20069587
//  November 19th, 2018
//	CISC220

// This program is a stack structure using linked lists.
// The stack has a max of 3.

#include<stdio.h>
#include <stdlib.h> 
#define MAXCHAR 100

// Defining a node
typedef struct node {
	char *data;
	struct node* next;
}node;

//Function to get size of linked list / stack
int getSize(struct node* head) {
	int count = 0;
	struct node* current = head;
	if(current == NULL) {
		return 0;
	} else {
		while (current != NULL) {
			count++;
			current = current->next; 
		}
	}
	return count;
}

// Removes "top" value in stack
node* pop(struct node *head) {
	printf("Popping\n");
    if(getSize(head) > 0) {
   	 	struct node* tmp = head;
    	if(head->next != NULL) {
    		head = head->next;
    	}else {
    		head = NULL;
    	}
    	free(tmp);
    	return head;
	} else{
		printf("Cannot pop an empty stack.\n");
		return head;
	}
}

// Adds value to stack
node* push(struct node* head, char *data) {
	printf("Pushing\n");
	if(getSize(head) < 3) {
		struct node* tmp = (struct node*)malloc(sizeof(struct node));
		tmp->data = malloc(MAXCHAR*sizeof(char));
	    tmp->data = data;
	    tmp->next = head;
	    head = tmp;
	    return head;
	}else {
		printf("The stack is full and cannot take any more elements.\n");
		return head;
	}
}

// Output formatting for stack
void displayStack(struct node* head) {
	if(getSize(head) > 0) {
		struct node* current;
		current = head;
		printf("The stack status: { '%s' ", current->data);
		current = current->next;
		while(current != NULL) {
			printf(", '%s' ", current->data);
			current = current->next;
		}
		printf("}\n");
	} else {
		printf("The stack is empty\n");
	}
	
}

int main() {
	char *list[] = {"First Element", "Second Element", "Third Element", "Fourth Element"};
	struct node* head = NULL;  
	head = NULL; 
	printf("Creating a Stack that can take only 3 elements.\n");
	int listSize = (sizeof(list)/sizeof(list[0]));
	
	//Pushing and popping // tests
	for(int i=0; i < listSize; i++) {
		head = push(head, list[i]);
		if(i != listSize - 1) {
			displayStack(head);
		}
	}
	for(int i=0; i < listSize; i++) {
		head = pop(head);
		if(i != listSize - 1) {
			displayStack(head);
		}
	}
	printf("End of program");
}