#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int make_neg(int a);
void subtract(int a, int b);
int multiply(int a, int b);
void exponent(int a, int b);
void divide(int a, int b);

int main(void)
{
    int a;
    int b;
    char operator;
    while (scanf("%i %c %i", &a, &operator, &b) == 3) {
        if (operator == '/') {
            divide(a, b);
        }
        if (operator == '*') {
            printf("%i\n", multiply(a, b));
        }
        if (operator == '^') {
            exponent(a, b);
        }
        if (operator == '-') {
            subtract(a, b);
        }
        if (operator == '+') {
            printf("%i\n", a + b);
        }
    }
}

int make_neg(int a)
{
    int min = INT_MIN + 2147483647;
    return multiply(a, min);
}

void subtract(int a, int b)
{
    int c = make_neg(b);
    printf("%i\n", a + c);
}

int multiply(int a, int b)
{
    int c = 0;
    if (a < 0 && b > 0) {
        for (int i = 0; i < b; i++) {
            c += a;
        }
    } else if (b < 0 && a > 0) {
        for (int i = 0; i < a; i++) {
            c += b;
        }
    } else {
        a = abs(a);
        b = abs(b);
        for (int i = 0; i < a; i++) {
            c += b;
        }
    }
    return c;
}

void exponent(int a, int b)
{
    if (b < 0) {
        printf("Non-integral answer\n");
    }
    int count = 0;
    int c = 1;
    while (count < b) {
        c = multiply(a, c);
        count++;
    }
    if (b >= 0) {
        printf("%i\n", c);
    }
}

void divide(int a, int b)
{
    int negative = 1;
    if (b == 0) {
        printf("Not-defined\n");
    }
    if ((a < 0 && b > 0) || (a > 0 && b < 0)) {
        negative = 0;
    }
    a = abs(a);
    b = abs(b);
    int count = 0;
    int c = 0;
    while (c < a) {
        c += b;
        count++;
    }
    if (negative == 0) {
        count = make_neg(count);
    }
    if (c == a && b != 0) {
        printf("%i\n", count);
    } else if (c != a) {
        printf("Non-integral answer\n");
    }
}
