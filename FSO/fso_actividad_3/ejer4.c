#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main()
{
	char program_name[20];

	while (1)
	{
		printf("Enter the file name:");
		scanf("%s", program_name);
		if (strcmp(program_name, "exit") == 0)
		{
			break;
		}
		system(program_name);
	}
	return 0;
}