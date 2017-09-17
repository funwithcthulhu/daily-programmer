#include <stdio.h>

int main(void)
{
    int bottles = 99;
    for (int i = bottles; i > 0; i--) {
        printf("%i bottles of beer on the wall, %i bottles of beer...", i, i);
        printf("Take one down, pass it around... %i bottles of beer on the wall", i - 1);
    }
}
