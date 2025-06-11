#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/shm.h>

int main(int argc, char *argv[])
{
	// Here we store the gradchild pid to be killed
	pid_t *gch_ps;
	pid_t *ch_ps;
	// A shared index to know where we need to store the next pid
	int *p_sh_index;

	// Create the shared memory
	int shmid_pids = shmget(0x1607, sizeof(pid_t) * 6, 0666 | IPC_CREAT);
	int shmid_index = shmget(0x1608, sizeof(int), 0666 | IPC_CREAT);

	// Atatch it
	gch_ps = (pid_t *)shmat(shmid_pids, NULL, 0);
	p_sh_index = (int *)shmat(shmid_index, NULL, 0);

	ch_ps = (pid_t *)malloc(sizeof(pid_t) * 2);

	// We initialize as 0
	*p_sh_index = 0;

	pid_t p = 1;

	for (int i = 0; i < 2; i++)
	{
		// only if we are the parent process we
		// create the 2 child process
		if (p != 0)
		{
			p = fork();
			ch_ps[i] = p;
		}
	}
	if (p == 0)
	{
		pid_t gcp = 1;
		for (int i = 0; i < 3; i++)
		{
			// And only if we are the child we create
			// grandchildren
			if (gcp != 0)
				gcp = fork();
		}

		if (gcp == 0)
		{
			// If we are the grandchildren
			gch_ps[*p_sh_index] = getpid();
			*p_sh_index = *p_sh_index + 1;
			printf("Adding grand child: %d\n", getpid());
		}

		sleep(20);
	}
	else
	{
		sleep(5);
		for (int i = 0; i < 6; i++)
		{
			printf("Killing grand child: %d\n", gch_ps[i]);
			kill(gch_ps[i], 9);
		}
		for (int i = 0; i < 2; i++)
		{
			printf("Killing child: %d\n", ch_ps[i]);
			kill(ch_ps[i], 9);
		}
	}

	shmdt(p_sh_index);
	shmctl(shmid_index, IPC_RMID, NULL);

	shmdt(gch_ps);
	shmctl(shmid_pids, IPC_RMID, NULL);

	free(ch_ps);

	return 0;
}
