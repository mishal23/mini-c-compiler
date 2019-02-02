#include<stdio.h>

int square(int a)
{
	return(a*a);
}

/*struct abc
{
	int a;
	char b;
};*/

int main()
{
	int num = 2;
	int num2 = square(num);
	
	printf("Square of %d is %d", num, num2);

	return 0;
}
