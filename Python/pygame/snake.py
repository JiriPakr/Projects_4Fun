
import pygame
import time
import random

pygame.init()
## DISPLAY
WIDTH = 800                                               # Window size
WIN = pygame.display.set_mode((WIDTH,WIDTH))
pygame.display.set_caption("Snake")

## COLORS
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)
L_BLUE = (0, 128, 255)
CYAN = (0, 255, 255)
WHITE = (255, 255, 255)
GREY = (128, 128, 128)
BLACK = (0, 0, 0)

class Snake:
    def __init__(self, xpos_h, ypos_h, width, length, color):
        self.xpos_h = xpos_h
        self.ypos_h = ypos_h
        self.width = width
        self.length = length
        self.color = color

    def get_pos(self):
        return self.xpos_h, self.ypos_h

    def set_color_black(self):
        self.color = BLACK

    #def draw(self, win):
    #    pygame.draw.line(win, self.color, )


font_style = pygame.font.SysFont(None, 200)

def message(msg,color):
    mesg = font_style.render(msg, True, color)
    WIN.blit(mesg, [0+70, WIDTH/2-100])

def main(win, width):

    snake_chunk = 20
    snake_len = 0

    x1 = WIDTH/2 - 20
    y1 = WIDTH/2 - 20

    x1_move = 0
    y1_move = 0

    food_x = round(random.randrange(0, WIDTH - snake_chunk ) / 20.0) * 20.0
    food_y = round(random.randrange(0, WIDTH - snake_chunk ) / 20.0) * 20.0

    sn_chunk_posmod_x = 0
    sn_chunk_posmod_y = 0


    run = True
    game_over = False
    clock = pygame.time.Clock()

    while run and not game_over:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE: 
                    pygame.quit()                    
        
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT or event.key == pygame.K_a:
                    x1_move = -snake_chunk
                    y1_move = 0
                    sn_chunk_posmod_x = snake_chunk
                    sn_chunk_posmod_y = 0
                elif event.key == pygame.K_RIGHT or event.key == pygame.K_d:
                    x1_move = snake_chunk
                    y1_move = 0
                    sn_chunk_posmod_x = -snake_chunk
                    sn_chunk_posmod_y = 0
                elif event.key == pygame.K_UP or event.key == pygame.K_w:
                    x1_move = 0
                    y1_move = -snake_chunk
                    sn_chunk_posmod_x = 0
                    sn_chunk_posmod_y = snake_chunk
                elif event.key == pygame.K_DOWN or event.key == pygame.K_s:
                    x1_move = 0
                    y1_move = snake_chunk
                    sn_chunk_posmod_x = 0
                    sn_chunk_posmod_y = -snake_chunk

        if x1 >= width or x1 <= 0 or y1 >= width or y1 <= 0:
            game_over = True

        x1 += x1_move
        y1 += y1_move            

        win.fill(WHITE) 
        snake_head = pygame.draw.rect(WIN, BLUE, [x1, y1, snake_chunk ,snake_chunk])
        snake_body = [snake_head]
        snake_body_chunk = pygame.draw.rect(WIN, L_BLUE, [(x1+sn_chunk_posmod_x*snake_len), (y1+sn_chunk_posmod_y*snake_len), snake_chunk ,snake_chunk])
        snake_body.append(snake_body_chunk)
        food = pygame.draw.rect(WIN, RED, [food_x,food_y, snake_chunk ,snake_chunk])
        pygame.display.update()

        if x1 == food_x and y1 == food_y:
            food_x = round(random.uniform(0 + 2*snake_chunk, WIDTH - 2*snake_chunk ) / 20.0) * 20.0
            food_y = round(random.uniform(0 + 2*snake_chunk, WIDTH - 2*snake_chunk ) / 20.0) * 20.0
            snake_len += 1
            print(snake_body)
        clock.tick(15)

    if game_over == True:
        win.fill(BLACK) 
        message("YOU DIED",RED)
        pygame.display.update()
        time.sleep(2)
    
    
main(WIN,WIDTH)