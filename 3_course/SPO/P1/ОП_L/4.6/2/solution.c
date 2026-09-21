#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/select.h>

int main() {
    int fd1, fd2;
    char buf[256];
    int n;
    int sum = 0;
    int fd1_open = 1, fd2_open = 1;
    
    fd1 = open("in1", O_RDONLY | O_NONBLOCK);
    fd2 = open("in2", O_RDONLY | O_NONBLOCK);
    
    if (fd1 < 0 || fd2 < 0) {
        return 1;
    }
    
    while (fd1_open || fd2_open) {
        fd_set readfds;
        int maxfd = 0;
        
        FD_ZERO(&readfds);
        
        if (fd1_open) {
            FD_SET(fd1, &readfds);
            if (fd1 > maxfd) maxfd = fd1;
        }
        
        if (fd2_open) {
            FD_SET(fd2, &readfds);
            if (fd2 > maxfd) maxfd = fd2;
        }
        
        if (select(maxfd + 1, &readfds, NULL, NULL, NULL) < 0) {
            break;
        }
        
        if (fd1_open && FD_ISSET(fd1, &readfds)) {
            n = read(fd1, buf, sizeof(buf) - 1);
            if (n > 0) {
                buf[n] = '\0';
                sum += atoi(buf);
            } else if (n == 0) {
                close(fd1);
                fd1_open = 0;
            }
        }
        
        if (fd2_open && FD_ISSET(fd2, &readfds)) {
            n = read(fd2, buf, sizeof(buf) - 1);
            if (n > 0) {
                buf[n] = '\0';
                sum += atoi(buf);
            } else if (n == 0) {
                close(fd2);
                fd2_open = 0;
            }
        }
    }
    
    printf("%d\n", sum);
    return 0;
}
