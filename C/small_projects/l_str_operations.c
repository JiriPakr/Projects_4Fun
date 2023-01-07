#include <string.h>
#include <stdio.h>

char str1[6] = "string";
char str2[6] = {'h','e','l','l','o','\0'};
char text[20];
char text2[30];
int num = 69;

int main()  {

    printf("\nEnter a text: ");
    //
    
    fgets(text, 20, stdin); /* or gets(text) or scanf("%s",text) */
    printf("\n%s\n",text);  /*or puts(text) or fputs(text, stdout)*/
    // sprintf - print to string, then printed with printf, sscanf works the same with input
    sprintf(text2, "the text is random %d", num);
    printf("%s\n", text2);

    // string concatenate
    strcat(str1, text);
    printf("\nstrcat: %s\n ",str1);

    // string copy
    strcpy(str1, str2);
    printf("\nstrcpy: %s\n",str1);

    // string compare
    int result;
    result = strcmp(str1,str2);
    printf("\nstrcmp: %d\n",result);
    return 0;

    // TO DO:
    // string find char
    /*strchr(str1,c)*/

    // string search
    /*strrchr(str1,c)*/

    // string find strinmg
    /*strstr(str1,str2)*/

    // atoi ...
}