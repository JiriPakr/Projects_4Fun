 // learn memory allocation
 // included in standard library

/* COMMANDS:
malloc(bytes) - Returns a pointer to a contiguous block of memory that is of size bytes.

calloc(num_items, item_size) - Returns a pointer to a contiguous block of memory that has num_items items, each of size item_size bytes.
Typically used for arrays, structures, and other derived data types. The allocated memory is initialized to 0.

realloc(ptr, bytes) - Resizes the memory pointed to by ptr to size bytes. The newly allocated memory is not initialized.

free(ptr) - Releases the block of memory pointed to by ptr. 
*/
/* NOTES:
->When allocating memory for a string pointer, you may want to use string length rather than the sizeof operator for calculating bytes. 

->When using strlen to determine the number of bytes needed for a string, be sure to include one extra byte for the NULL character '\0'. 
*/

#include <stdio.h>
#include <stdlib.h>

 // Dynamic array]
    typedef struct {
        int *elements;
        int size;
        int cap;
    } dynamic_array;

 int main() {

    // allocating 10 ints
    int *ptr1;
    // allocates 10 "blocks" of ints
    ptr1 = malloc(10*sizeof(*ptr1));
    if (ptr1 != NULL) {
        *(ptr1+1) = 2;
        *ptr1 = 1;
    }

    printf("\n[OUTPUT]: %d\n", *(ptr1));
    printf("[OUTPUT]: %d\n", *(ptr1+1));
    printf("[OUTPUT]: %d\n", *(ptr1+9));
    printf("[OUTPUT]: %d\n", *(ptr1+10));
    printf("[OUTPUT]: %d\n", ptr1);


    // reallocating memory to 20 ints
    ptr1 = realloc(ptr1, 20*sizeof(*ptr1)); 
    *(ptr1+15) = 75;
    printf("[OUTPUT2]: %d %d\n", *(ptr1+1), *(ptr1+15));


    // Freeing memory
    free(ptr1);
    printf("[OUTPUT3]: %d\n", *(ptr1));


    // Dynamic array allocation
    dynamic_array arr;
    int i;

    // init array
    arr.size = 0;
    arr.elements = calloc(1, sizeof(*arr.elements));
    arr.cap = 1;    // room for 1 element

    // expand by 5 more elements
    arr.elements = realloc(arr.elements, (5 + arr.cap)*sizeof(*arr.elements));
    if (arr.elements != NULL) 
        arr.cap += 5;
    
    // add an element and increase size
    if (arr.size < arr.cap) {
        arr.elements[arr.size] = 10;
        arr.size++;
    }
    else
        printf("[INFO]: Need to expand array");

    // display array elements
    for (i = 0; i < arr.cap; i++)
        printf("[OUTPUT4]: Element%d = %d\n",i, arr.elements[i]);

    printf("\n");
    return 0;
 }

