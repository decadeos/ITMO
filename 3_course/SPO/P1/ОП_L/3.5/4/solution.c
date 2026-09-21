#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        return 1;
    }
    
    int pid = atoi(argv[1]);
    char path[256];
    FILE *fp;
    char line[256];
    int ppid;
    
    while (pid != 1) {
        printf("%d\n", pid);
        
        sprintf(path, "/proc/%d/stat", pid);
        fp = fopen(path, "r");
        if (fp == NULL) {
            return 1;
        }
        
        fgets(line, sizeof(line), fp);
        fclose(fp);
        
        sscanf(line, "%*d %*s %*c %d", &ppid);
        pid = ppid;
    }
    
    printf("1\n");
    return 0;
}
