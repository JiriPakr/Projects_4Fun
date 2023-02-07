// included in stdio - standard input output
/*
Format specifiers begin with a percent sign % and are used to assign values to corresponding arguments after the control string. Blanks, tabs, and newlines are ignored. 
The conversion character converts the argument, if necessary, to the indicated type:
d decimal
c character
s string
f float
x hexadecimal 
To print the % symbol, use %% in the format string. 
%[-][width].[precision]conversion character 
The optional width gives the minimum number of characters for the data.
The period . separates the width from the precision.
The optional precision gives the number of decimal places for numeric data. 
If s is used as the conversion character, then precision determines the number of characters to print. 

Escape sequences begin with a backslash \:
\n new line
\t horizontal tab
\\ backslash
\b backspace
\' single quote
\" double quote 
*/

#include <stdio.h>

int main() {
    int xi = 5;
    float xf = 1.5;
    char xs[4] = "ahoj";
    int xh = 15;
    printf("\n[OUTPUT] int: %d\n[OUTPUT] float: %4.2f\n[OUTPUT] string: %s\n[OUTPUT] hex: %x\n", xi, xf, xs, xh);
    printf("\n");
    return 0;
}