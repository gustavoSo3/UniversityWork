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
		pid_t ppid = getppid();
		printf("Killing parent with pid: %d\n", ppid);
		kill(ppid, 9);
		exit(0);
	}

	wait(NULL);

	return 0;
}
