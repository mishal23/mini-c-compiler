#include<stdio.h>

struct pair{
    int a;
    int b;
};

int fun(int x){
    return x*x;
}

int main(){
    int a,b,c,d,e,f,g,h;
    a=2,b=5;

    c=a+b;
    d=a*b;
    e=a/b;
    f=a%b;
    g=a&b;
    h=a|b;
    h=a*(a+b);
    h=a*a+b*b;
    h=fun(b);
    
    //This Test case contains operator,structure,delimeters,Function;
}
