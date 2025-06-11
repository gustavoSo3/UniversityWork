#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
	pid_t p = fork();

	if (p == 0)
	{
		sleep(1);
		exit(0);
	}

	sleep(20);
	wait(NULL);

	return 0;
}
