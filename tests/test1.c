#include<stdio.h>//Header Files

int main(){
    int n,i;//Integer Datatype
    scanf("%d",&n);//Scan Function
    char ch;//Character Datatype
    scanf("%d",&ch);

    for (i=0;i<n;i++){
        if(i<10){
            int x;
            while(x<10){
                printf("%d\t",x);
                x++;
            }
        }

        else printf("Okay!\n");
    }
    /*
    This File Contains Test cases about Datatypes,Keyword,Identifier,Nested For and while loop,
    Conditional Statement,Single line Comment,MultiLine Comment etc.*/
    
}
