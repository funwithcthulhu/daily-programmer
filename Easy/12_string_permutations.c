// attempt at implementing Heap's algorithm
#include <stdio.h>
#include <string.h>

void permutate(char a[], int size, int n);

int main(void) 
{
    char a[20];
    printf("Input: ");
    scanf("%s", a);
    int n = strlen(a);
    permutate(a, n, n);
    return 0;
}

void permutate(char a[], int size, int n)
{
    if (size == 1) {
        printf("%s\n", a);
        return;
    }
    char tmp;
    for (int i = 0; i < size; i++) {
        permutate(a, size - 1, n);

        if (size % 2 == 1) {
            tmp = a[0];
            a[0] = a[size - 1];
            a[size - 1] = tmp;
        } else {
            tmp = a[i];
            a[i] = a[size - 1];
            a[size - 1] = tmp;
        }
    }
}

