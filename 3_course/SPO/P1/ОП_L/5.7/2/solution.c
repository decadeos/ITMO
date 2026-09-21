#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <port>\n", argv[0]);
        return 1;
    }
    
    int port = atoi(argv[1]);
    
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        perror("socket");
        return 1;
    }
    
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind");
        close(sock);
        return 1;
    }
    
    char buffer[5 * 1024 + 1];
    struct sockaddr_in client_addr;
    socklen_t client_len = sizeof(client_addr);
    
    while (1) {
        ssize_t n = recvfrom(sock, buffer, 5 * 1024, 0,
                            (struct sockaddr *)&client_addr, &client_len);
        if (n < 0) {
            perror("recvfrom");
            break;
        }
        
        buffer[n] = '\0';
        
        if (strcmp(buffer, "OFF\n") == 0) {
            break;
        }
        
        printf("%s", buffer);
        fflush(stdout);
    }
    
    close(sock);
    return 0;
}
