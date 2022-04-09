from locale import currency
from tempfile import SpooledTemporaryFile
import pygame
import math
from queue import PriorityQueue


#  VISUALIZATION -------------------------------------------
## DISPLAY
WIDTH = 1000                                               # Window size
WIN = pygame.display.set_mode((WIDTH,WIDTH))
pygame.display.set_caption("A*")

## COLORS
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)
L_BLUE = (0, 128, 255)
CYAN = (0, 255, 255)
WHITE = (255, 255, 255)
GREY = (128, 128, 128)
BLACK = (0, 0, 0)

class Node:
    def __init__(self, row, col, width, total_rows):
        self.row = row
        self.col = col
        self.x = row * width
        self.y = col * width
        self.color = WHITE
        self.neighbors = []
        self.width = width
        self.total_rows = total_rows

    def get_pos(self):
        return self.row, self.col

    #

    def is_closed(self):
        return self.color == RED

    def is_open(self):
        return self.color == GREEN

    def is_barrier(self):
        return self.color == BLACK

    def is_start(self):
        return self.color == L_BLUE

    def is_end(self):
        return self.color == BLUE

    def is_empty(self):
        return self.color != BLACK

    def reset(self):
        self.color = WHITE

    #

    def make_closed(self):
        self.color = RED
    
    def make_open(self):
        self.color = GREEN

    def make_barrier(self):
        self.color = BLACK

    def make_start(self):
        self.color = L_BLUE

    def make_end(self):
        self.color = BLUE

    def make_path(self):
        self.color = CYAN

    def draw(self, win):
        pygame.draw.rect(win, self.color, (self.x, self.y, self.width, self.width))

    def update_neighbors(self, grid):
        self.neighbors = []
        if self.row < self.total_rows - 1 and not grid[self.row + 1][self.col].is_barrier():    # going thru rows DOWN
            self.neighbors.append(grid[self.row + 1][self.col])

        if self.row > 0 and not grid[self.row - 1][self.col].is_barrier():    # UP
            self.neighbors.append(grid[self.row - 1][self.col])

        if self.col < self.total_rows - 1 and not grid[self.row][self.col + 1].is_barrier():    # goint thru cols RIGHT
            self.neighbors.append(grid[self.row][self.col + 1])

        if self.col > 0 and not grid[self.row][self.col - 1].is_barrier():    # LEFT
            self.neighbors.append(grid[self.row][self.col - 1])

## A* algo ---------------------------------------------------------------------

def h_score(p1, p2):                                                               # Heuristic function - Manhattan distance
    x1, y1 = p1                                                                      # p1 = (x1,y1)
    x2, y2 = p2
    return abs(x1 - x2) + abs(y1 - y2)


def Astar(draw, grid, start, end):
    count = 0
    open_set = PriorityQueue()                                                     # Set to look thru (PriorQ - efficient to get smallest element from it)
    open_set.put((0, count, start))                                                # Putting start to the set
    came_from = {}                                                                 # Keeping track where it came from to find best path at the end
    g_score = {node: float("inf") for row in grid for node in row}                 # Shortest path from start node to current node (init distance = inf)
    g_score[start] = 0
    f_score = {node: float("inf") for row in grid for node in row}                 
    f_score[start] = h_score(start.get_pos(), end.get_pos())                       # Predicted distance from start to end node

    open_set_hash = {start}

    while not open_set.empty():                                                     # if set is empty -> quit
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()

        current = open_set.get()[2]                                                 # get smallest f_score element
        open_set_hash.remove(current)                                               # and remove it

        if current == end:                                                          # if at the end, found path -> finished
            reconstruct_path(came_from, end, draw)
            start.make_start()
            end.make_end()
            return True # make path

        for neighbor in current.neighbors:                                          # otherwise consider all neighbours of currnt node
            temp_g_score = g_score[current] + 1                                     # and calc their temp g_score

            if temp_g_score < g_score[neighbor]:                                    # if their its less than g_score in a table
                came_from[neighbor] = current                                       # update
                g_score[neighbor] = temp_g_score
                f_score[neighbor] = temp_g_score + h_score(neighbor.get_pos(), end.get_pos())
                if neighbor not in open_set_hash:                                   # and add to open set hash
                    count += 1
                    open_set.put((f_score[neighbor], count, neighbor))
                    open_set_hash.add(neighbor)
                    neighbor.make_open()

        draw()

        if current != start:
            current.make_closed()

    
    return False

##------------------------------------------------------------------------------

def reconstruct_path(came_from, current, draw):
    while current in came_from:
        current = came_from[current]
        current.make_path()
        draw()


def make_grid(rows, width):
    grid = []
    gap = width // rows
    for i in range(rows):
        grid.append([])
        for j in range(rows):
            node = Node(i, j, gap, rows)
            grid[i].append(node)
    
    return grid


def draw_grid(win, rows, width):
    gap = width // rows
    for i in range(rows):
        pygame.draw.line(win, GREY, (0, i * gap), (width, i * gap))                 #
        for j in range(rows):
            pygame.draw.line(win, GREY, (j * gap, 0), (j * gap, width))             #


def draw(win, grid, rows, width):
    win.fill(WHITE)                                                                  # Redrawing at every frame (not optimal)

    for row in grid:
        for node in row:
            node.draw(win)

    draw_grid(win, rows, width)
    pygame.display.update()


    pass
def get_click_pos(pos, rows, width):
    gap = width // rows
    y, x = pos

    row = y // gap
    col = x // gap

    return row, col


def main(win, width):
    ROWS = 50
    grid = make_grid(ROWS, width)

    start = None
    end = None

    run = True
    while run:
        draw(win, grid, ROWS, width)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                run = False


            if pygame.mouse.get_pressed()[0]:                       # if lmb pressed (left mouse button - 0, middlemb - 1, rmb - 2) add nodes
                pos = pygame.mouse.get_pos()
                row, col = get_click_pos(pos, ROWS, width)
                node = grid[row][col]
                if not start and node != end :
                    start = node
                    start.make_start()
                    print("[INFO] Adding start on: X =",row,", Y =",col)

                elif not end and node != start:
                    end = node
                    end.make_end()
                    print("[INFO] Adding end on: X =",row,", Y =",col)

                elif node != end and node != start and node.is_empty():
                    node.make_barrier()
                    print("[INFO] Adding barrier on: X =",row,", Y =",col)

            elif pygame.mouse.get_pressed()[2]:                     # if rmb pressed remove nodes
                pos = pygame.mouse.get_pos()
                row, col = get_click_pos(pos, ROWS, width)
                node = grid[row][col]
                if node.is_barrier():
                    node.reset()
                    print("[INFO] Removing barrier on: X =",row,", Y =",col)
                if node == start:
                    node.reset()
                    start = None
                    print("[INFO] Removing start on: X =",row,", Y =",col)
                elif node == end:
                    node.reset()
                    end = None
                    print("[INFO] Removing end on: X =",row,", Y =",col)
            
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_SPACE and start and end:    # if space pressed start algo

                    for row in grid:
                        for node in row:
                            node.update_neighbors(grid)
                            
                    print("[INFO] Chosen A*")
                    Astar(lambda: draw(win, grid, ROWS, width), grid, start, end)   #lambda - anonymous function (one-time use function)

                if event.key == pygame.K_c:
                    print("[INFO] Clearing environment")
                    start = None
                    end = None
                    grid = make_grid(ROWS, width)

    pygame.quit()

main(WIN, WIDTH)
