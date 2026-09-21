#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *fp;
    char line[256];
    int pid, ppid;
    
    fp = fopen("/proc/self/stat", "r");
    if (fp == NULL) {
        return 1;
    }
    
    fgets(line, sizeof(line), fp);
    sscanf(line, "%d %*s %*c %d", &pid, &ppid);
    
    printf("%d\n", ppid);
    
    fclose(fp);
    return 0;
}
