//  Ryan Protheroe
//  20069587
//  October 23rd, 2018

//  This program takes an "A" and "B" value, both needing to be between 5 and 50,
//  and conducts bitwise arithmetic based on choices 1,2 and 3, (&, |, ^).
//  It also filters out alphabetic characters, allowing only integers between
//  5 and 50.

#include<stdio.h>
#include<stdlib.h>
#define abMIN 5
#define abMAX 50
#define cMIN 1
#define cMAX 3
#define END -1

int main() {
int a=0;
int b=0;
int choice=0;

 while (a < abMIN || a > abMAX) {
  printf("Enter a value of 'A': ");
  if(scanf("%d",&a) != 0) {
      if (a == END) {
        printf("The program has been terminated.\n");
        exit(0);
      }
      else if (a < abMIN || a > abMAX ) {
        printf("You have entered a value out of accepted range,\nenter a number between 5 and 50\n");
      }
  } else {
      printf("You entered an alphabetic character(s), enter a number between 5 and 50\n");
      while((a = getchar()) != '\n' && a != EOF);
      a=0;
  }
}

 while (b < abMIN || b > abMAX) {
  printf("Enter a value of 'B': ");
  if(scanf("%d",&b) != 0) {
      if (b == END) {
        printf("The program has been terminated.\n");
        exit(0);
      }
      else if (b < abMIN || b > abMAX ) {
        printf("You have entered a value out of accepted range,\nenter a number between 5 and 50\n");
      }
  } else {
      printf("You entered an alphabetic character(s), enter a number between 5 and 50\n");
      while((b = getchar()) != '\n' && b != EOF);
      b=0;
    }
 }

 while (choice < cMIN || choice > cMAX) {
   printf("Enter 1 for A & B \nEnter 2 for A | B \nEnter 3 for A ^ B \nEnter your choice: ");
   if(scanf("%d",&choice) != 0) {
      if (choice == END) {
        printf("The program has been terminated.\n");
        exit(0);
      }
      else if (choice < cMIN || choice > cMAX ) {
        printf("Your entry is not accepted; it must be 1-3.\n");
      }
  } else {
      printf("You entered an alphabetic character(s), enter a number between 5 and 50\n");
      while((choice = getchar()) != '\n' && choice != EOF);
      choice=0;
    }
 }
  
 switch(choice) {
 case 1:
   printf("%d & %d = %d\n",a,b,a&b);
   break;
 case 2:
   printf("%d | %d = %d\n",a,b,a|b);
   break;
 case 3:
   printf("%d ^ %d = %d\n",a,b,a^b);
   break;
 }
}
