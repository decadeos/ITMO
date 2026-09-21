#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdio.h>
#include <stdlib.h>

#define SHMSZ 1000

int main(int argc, char *argv[]) {
    int shmid[3];
    int *shm[3];
    key_t key_new;
    
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <key1> <key2>\n", argv[0]);
        exit(1);
    }
    
    if ((shmid[1] = shmget((key_t)atoi(argv[1]), SHMSZ, 0666)) < 0) {
        perror("shmget for region 1");
        exit(1);
    }
    
    if ((shmid[2] = shmget((key_t)atoi(argv[2]), SHMSZ, 0666)) < 0) {
        perror("shmget for region 2");
        exit(1);
    }
    
    if ((shmid[0] = shmget(IPC_PRIVATE, SHMSZ, IPC_CREAT | 0666)) < 0) {
        perror("shmget for new region");
        exit(1);
    }
    
    if ((shm[0] = (int *)shmat(shmid[0], NULL, 0)) == (int *)-1) {
        perror("shmat for new region");
        exit(1);
    }
    
    if ((shm[1] = (int *)shmat(shmid[1], NULL, 0)) == (int *)-1) {
        perror("shmat for region 1");
        exit(1);
    }
    
    if ((shm[2] = (int *)shmat(shmid[2], NULL, 0)) == (int *)-1) {
        perror("shmat for region 2");
        exit(1);
    }
    
    for (int i = 0; i < 100; i++) {
        shm[0][i] = shm[1][i] + shm[2][i];
    }
    
    key_new = ftok(argv[0], 1);
    shmdt(shm[0]);
    shmctl(shmid[0], IPC_RMID, NULL);
    
    if ((shmid[0] = shmget(key_new, SHMSZ, IPC_CREAT | 0666)) < 0) {
        perror("shmget with key");
        exit(1);
    }
    
    shm[0] = (int *)shmat(shmid[0], NULL, 0);
    for (int i = 0; i < 100; i++) {
        shm[0][i] = shm[1][i] + shm[2][i];
    }
    
    printf("%d\n", key_new);
    
    return 0;
}
