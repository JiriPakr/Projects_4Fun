#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int height = 20, width = 40;
int gameover = 0, score;
int snake_x = 20, snake_y = 10;
int flag;


void draw() {
    system("cls");
    for (int i=0; i <= height; i++) {
        for (int j=0; j <= width; j++) {
            if (i == 0 || i == height || j == 0 || j == width) {
                printf("#");
            }
            else if (j == snake_x &&  i == snake_y) {
                printf("0");
            }
            else {
                printf(" ");
            }
        }
        printf("\n");
    }
}

void input() {
    if (kbhit()) {
        switch (getch()) {
            case 'a':
                flag = 1;
                break;
            case 'w':
                flag = 2;
                break;
            case 's':
                flag = 3;
                break;
            case 'd':
                flag = 4;
                break;
            case 'x':
                gameover = 1;
                break;
        }
    }
}

void logic() {
    sleep(0.01);
    switch (flag) {
        case 1:
            snake_x--;
            break;
        case 2:
            snake_y--;
            break;
        case 3:
            snake_y++;
            break;
        case 4:
            snake_x++;
            break;
        default:
            break;
    }
    if (snake_x < 0 || snake_y < 0 || snake_x > width || snake_y > height){
        gameover = 1;
    }
}

int main() {
    while (!gameover) {
        system("cls");
        draw();
        input();
        logic();
        //sleep(0.2);
    }
    
    return 0;
    }
