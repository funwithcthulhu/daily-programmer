#include <stdio.h>

int main(void)
{
	char name[20];
	char age[20];
	char usr[20];

	printf("Name: ");
	scanf("%19s", name);
	printf("Age: ");
	scanf("%19s", age);
	printf("Username: ");
	scanf("%19s", usr);

	printf("Your name is %s, you are %s, and your username is %s\n", name, age, usr);
}
