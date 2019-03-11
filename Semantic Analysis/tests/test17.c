#include <stdio.h>

void func(int a, int b)
{
	return 5;
}

int main()
{
	int z = 5;
	func(5,z,z);
	printf("wow\n");
}