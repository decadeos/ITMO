#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    if (argc < 3) {
        return 1;
    }
    
    int pipefd[2];
    pipe(pipefd);
    
    pid_t pid = fork();
    
    if (pid == 0) {
        close(pipefd[0]);
        dup2(pipefd[1], STDOUT_FILENO);
        close(pipefd[1]);
        
        execl(argv[1], argv[1], argv[2], NULL);
        return 1;
    } else {
        close(pipefd[1]);
        
        char ch;
        int count = 0;
        
        while (read(pipefd[0], &ch, 1) > 0) {
            if (ch == '0') {
                count++;
            }
        }
        
        close(pipefd[0]);
        wait(NULL);
        
        printf("%d\n", count);
    }
    
    return 0;
}
