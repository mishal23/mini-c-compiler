#include <stdio.h>

int myfunc(int a,int b)
{
	return a+b;
}

void main()
{
	int a,b,i;

	while(a<3)
	{
		a = a+b;
		for(i=0;i<b;i++)
		{
			b++;
			myfunc(a,b);

		}
		a++;
	}
	
}