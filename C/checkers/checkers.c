#include <stdio.h>
#include <stdlib.h>

int width = 8, height = 8;
int gameover = 0;

void draw() {

    system("cls");
    for (int i=0; i <= height; i++) {
        for (int j=0; j <= width; j++){
            printf("0");
        }
        printf("\n");
    }
}

void input() {

}

void logic() {

}


int main()  {

    while (!gameover) {
        draw();
    }
    return 0;
}