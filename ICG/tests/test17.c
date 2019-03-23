#include <stdio.h>

void main()
{
	int a,b,c,d;

	//a = d * b + c;
	//a = (b-c)*d + (b-c)*d;
	//a = b+c*d;
	//a = b*(-c) + b*(-c);
	if (a<b)
	{
		if(c<d)
		{
		a = b+c*d;
		}
		else
		{
		a = d * b + c;
		}
	}
	else
	{
		a = (b-c)*d + (b-c)*d;
	}
}
