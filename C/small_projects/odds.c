#include<stdio.h>

int main(){
    int evns[] = {};
    int odds[] = {};
    int N = 100;
    
    for (int i = 1; i<N+1; i++) {
        if (i % 2 == 1) {
            evns[i] = i;
            //printf("%d ",evns[i]);
            //printf("\n"); 
            }
    }
    //printf("\n"); 
    for (int i = 1; i<N+1; i++) {
        if (i % 2 == 0) {
            odds[i] = i;
            //printf("%d ",odds[i]);
            //printf("\n"); 
            }
    }

    int odds_envs[][2] = {{0},{0}};
    for (int i = 1; i<N+1; i++) {
        if (i % 2 == 0) {
            odds_envs[i][1] = i;
            printf("%d ",odds_envs[i][1]);
        }
    }
    printf("\n"); 
    for (int i = 1; i<N+1; i++) {
        if (i % 2 == 1) {
            odds_envs[i][2] = i;
            printf("%d ",odds_envs[i][2]);
        }
    }
}