#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{

	int n = atoi(argv[1]);
	for (int i = 1; i <= n; i++)
	{
		pid_t p = fork();
		if (p == 0)
		{
			printf("Proceso hijo %d\n", i);
			exit(0);
		}
		else
		{
			wait(NULL);
		}
	}
	printf("FIN\n");
	return 0;
}