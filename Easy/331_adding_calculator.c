#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int make_neg(int a);
int subtract(int a, int b);
int multiply(int a, int b);
int exponent(int a, int b);
int divide(int a, int b);

int main(void)
{
    int a;
    int b;
    char operator;
    //scanf("%i %c %i", &a, &operator, &b);
    while (scanf("%i %c %i", &a, &operator, &b) == 3) {
        if (operator == '/') {
            printf("%i\n", divide(a, b));
        }
        if (operator == '*') {
            printf("%i\n", multiply(a, b));
        }
        if (operator == '^') {
            printf("%i\n", exponent(a, b));
        }
        if (operator == '-') {
            printf("%i\n", subtract(a, b));
        }
        if (operator == '+') {
            printf("%i\n", a + b);
        }
    }
}

int make_neg(int a)
{
    return -a;
}

int subtract(int a, int b)
{
    int c = make_neg(b);
    return a + c;
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

int exponent(int a, int b)
{
    if (b < 0) {
        printf("Non-integral answer\n");
        return 0;
    }
    int count = 0;
    int c = 1;
    while (count < b) {
        c = multiply(a, c);
        count++;
    }
    return c;
}

int divide(int a, int b)
{
    bool negative = false;
    if (b == 0) {
        printf("Not-defined\n");
        return 0;
    }
    if ((a < 0 && b > 0) || (a > 0 && b < 0)) {
        negative = true;
    }
    a = abs(a);
    b = abs(b);
    int count = 0;
    int c = 0;
    while (c < a) {
        c += b;
        count++;
    }
    if (negative) {
        count = make_neg(count);
    }
    if (c == a) {
        return count;
    } else {
        printf("Non-integral answer\n");
        return 0;
    }
}
