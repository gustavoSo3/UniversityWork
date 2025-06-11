#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

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
		pid_t p = fork();
		if (p == 0)
		{
			execlp(program_name, program_name, NULL);
		}
	}
	return 0;
}