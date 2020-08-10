//  Ryan Protheroe
//  20069587
//  November 12th, 2018
//	CISC220

// 	This program sorts an array of 7 randomly generated numbers in ascending order.
//	It uses a swap function with two arguments/pointers to swap the array.

#include<stdio.h>
#include <stdlib.h> 
#include <time.h> 
#define MAXSIZE 7

int main() {
	int MyArray[MAXSIZE];
	//	Putting random numbers in the array
	srand(time(0));
	for(int i = 0; i < MAXSIZE; i++) {
		MyArray[i] = (rand() % 99) + 1;
	}
	//	Printing out array
	for(int i = 0; i < MAXSIZE; i++) {
		printf("%d\t", MyArray[i]);
	}
	printf("\n");

	//	Sort
	for(int i = 0; i < MAXSIZE; i++) {
		for(int n = MAXSIZE; n > 1; n--) {
			// Swap
			if(MyArray[MAXSIZE-n] > MyArray[MAXSIZE-(n-1)]){
				swap(&MyArray[MAXSIZE-n],&MyArray[MAXSIZE-(n-1)]);
			}
		}
		//	Print array after iteration
		for(int i = 0; i < MAXSIZE; i++) {
		printf("%d\t", MyArray[i]);
	}
	printf("\n");

	//	Checks if sorted/ to stop the iterations
	int errorCount = 0;
	for(int r = 0; r < (MAXSIZE-1); r++) {
		if(MyArray[r] > MyArray[(r+1)]) {
			errorCount++;
		}
	}
	if(errorCount == 0) {
		break;
	}
	}
	printf("\n");
}

//	Swap method
void swap(int * n1, int * n2) {
	int temp;
    temp = *n1;
    *n1 = *n2;
    *n2 = temp;
}

