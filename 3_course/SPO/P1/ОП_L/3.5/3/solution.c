#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <ctype.h>

int main() {
    DIR *proc = opendir("/proc");
    struct dirent *entry;
    char path[256];
    char name[256];
    FILE *f;
    int count = 0;
    
    while ((entry = readdir(proc)) != NULL) {
        if (entry->d_name[0] < '0' || entry->d_name[0] > '9') {
            continue;
        }
        
        sprintf(path, "/proc/%s/comm", entry->d_name);
        f = fopen(path, "r");
        if (f) {
            if (fgets(name, sizeof(name), f)) {
                name[strlen(name) - 1] = '\0';
                if (strcmp(name, "genenv") == 0) {
                    count++;
                }
            }
            fclose(f);
        }
    }
    
    closedir(proc);
    printf("%d\n", count);
    return 0;
}
