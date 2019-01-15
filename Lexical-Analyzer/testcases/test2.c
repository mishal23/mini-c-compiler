//if-else
//switch-case
//++ operator, -- operator
//return

#include<stdio.h>

int main()
{
    char a = 'm';
    if(a == 'm') {
        return 1;
    } else {
        a++;
    }

    switch(a) {
        case 'l':
            a++;
            break;
        case 'm':
            a--;
            break;
        case 'n':
            a = a + 2;
            break;
        default:
            a = a + 3;
    }
    printf("%c",a);
}