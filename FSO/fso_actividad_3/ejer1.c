#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main()
{
	pid_t child_pid = fork();

	if (child_pid == 0)
	{
		for (int i = 0; i < 10; i++)
		{
			printf("Soy el hijo\n");
		}
	}
	else
	{
		for (int i = 0; i < 10; i++)
		{
			printf("Soy el padre\n");
		}
		wait(NULL);
		printf("Mi proceso hijo ha terminado\n");
	}

	return 0;
}