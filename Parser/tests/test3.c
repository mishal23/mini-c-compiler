#include<stdio.h>

int main(){
    char s[10]="Welcome!!";
    char s[]="Welcome!!";
    int a[2] = {1, 2};
    char S[20];

    int p;
    if(s[0]=='W'){
        if(s[1]=='e'){
            if(s[2]=='l'){
                printf("Welcome!!");
            }

            else printf("Bug1\n");
        }
        else printf("Bug2\n");
    }

    else printf("Bug3\n");

    // int @<-_-= 2;

    //This test case contains nested conditional statement,Array and print statement
    //Also there is an error in declaring integer variable which does not match any regular expression.
}
