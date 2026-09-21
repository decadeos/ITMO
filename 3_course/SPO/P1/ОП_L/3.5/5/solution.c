#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <ctype.h>

int count_descendants(int target_pid) {
    DIR *proc;
    struct dirent *entry;
    char path[256];
    FILE *fp;
    char line[256];
    int pid, ppid;
    int count = 1;
    
    proc = opendir("/proc");
    if (proc == NULL) {
        return 1;
    }
    
    while ((entry = readdir(proc)) != NULL) {
        if (!isdigit(entry->d_name[0])) {
            continue;
        }
        
        pid = atoi(entry->d_name);
        if (pid == target_pid) {
            continue;
        }
        
        sprintf(path, "/proc/%d/stat", pid);
        fp = fopen(path, "r");
        if (fp != NULL) {
            fgets(line, sizeof(line), fp);
            fclose(fp);
            
            sscanf(line, "%*d %*s %*c %d", &ppid);
            
            if (ppid == target_pid) {
                count += count_descendants(pid);
            }
        }
    }
    
    closedir(proc);
    return count;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        return 1;
    }
    
    int pid = atoi(argv[1]);
    int result = count_descendants(pid);
    
    printf("%d\n", result);
    return 0;
}
