#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int comp(const void *elem1, const void *elem2) {
    char f = *((char *)elem1);
    char s = *((char *)elem2);
    if (f < s) return 1;
    if (f > s) return -1;
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <port>\n", argv[0]);
        return 1;
    }
    
    int port = atoi(argv[1]);
    
    int ss = socket(AF_INET, SOCK_STREAM, 0);
    if (ss < 0) {
        perror("socket");
        return 1;
    }
    
    struct sockaddr_in local;
    memset(&local, 0, sizeof(local));
    local.sin_family = AF_INET;
    local.sin_port = htons(port);
    local.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if (bind(ss, (struct sockaddr *)&local, sizeof(local)) < 0) {
        perror("bind");
        close(ss);
        return 1;
    }
    
    if (listen(ss, 5) < 0) {
        perror("listen");
        close(ss);
        return 1;
    }
    
    int cs = accept(ss, NULL, NULL);
    if (cs < 0) {
        perror("accept");
        close(ss);
        return 1;
    }
    
    char buff[BUFSIZ];
    const char *target = "OFF";
    
    while (1) {
        memset(buff, 0, BUFSIZ);
        ssize_t len = read(cs, buff, BUFSIZ - 1);
        
        if (len <= 0) {
            break;
        }
        
        if (len > 0 && buff[len - 1] == '\n') {
            buff[len - 1] = '\0';
            len--;
        }
        
        if (strcmp(buff, target) == 0) {
            break;
        }
        
        qsort(buff, strlen(buff), sizeof(char), comp);
        
        write(cs, buff, strlen(buff));
        write(cs, "\0", 1);
    }
    
    close(cs);
    close(ss);
    return 0;
}
