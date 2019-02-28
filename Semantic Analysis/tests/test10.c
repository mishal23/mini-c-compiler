//modifiers
//arithmetic operation
//logical operations

#include<stdio.h>
int main()
{
    long int a, b;
    unsigned long int x;
    signed short int y;
    signed short z;
    int w;
    a = 23;
    b = 15;
    int c = a + b;
    printf("%d",c);
    c = a - b;
    printf("%d",c);
    c = a * b;
    printf("%d",c);
    c = a/b;
    printf("%d",c);
    c = a%b;
    printf("%d",c);

    c = (a>=b);
    printf("%d",c);
    c = (a<=b);
    printf("%d",c);
    c = (a==b);
    printf("%d",c);
    c = (a!=b);
    printf("%d",c);
}