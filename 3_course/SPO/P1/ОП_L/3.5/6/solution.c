#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>

int main() {
    pid_t pid = fork();
    
    if (pid < 0) {
        return 1;
    }
    
    if (pid > 0) {
        printf("%d\n", pid);
        return 0;
    }
    
    setsid();
    umask(0);
    chdir("/");
    
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);
    
    while (1) {
        sleep(1);
    }
    
    return 0;
}
