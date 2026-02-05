#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int i;
    pid_t pid;

    printf("Parent process PID: %d\n", getpid());

    // Create multiple child processes
    for (i = 0; i < 3; i++) {
        pid = fork();

        if (pid < 0) {
            perror("fork failed");
            exit(1);
        }

        if (pid == 0) {
            // Child process
            printf("Child %d created with PID %d\n", i + 1, getpid());
            sleep(1);   // simulate work
            exit(0);    // child terminates
        }
    }

    // Parent waits for all children to prevent zombies
    for (i = 0; i < 3; i++) {
        pid = wait(NULL);
        printf("Parent cleaned up child with PID %d\n", pid);
    }

    printf("All child processes cleaned up. No zombies remain.\n");
    return 0;
}
