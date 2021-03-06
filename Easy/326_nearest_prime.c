#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include <time.h>

bool isPrime(int n);

int main(void)
{
	clock_t start, end;
	double cpu_time_used;
	start = clock();
	
	long number;
	
	printf("Enter input number: ");
	scanf("%ld", &number);
	
	if (isPrime(number)) {
		printf("%ld is prime.\n", number);
	}
	long lower = number;
	long higher = number;

	while (!isPrime(lower)) {
		lower -= 1;
	}
	while (!isPrime(higher)) {
		higher += 1;
	}
	
	if (isPrime(number) == false) {
		printf("%ld < %ld < %ld\n", lower, number, higher);
	}

	end = clock();
	cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	printf("Timer: %ld finished in %f s\n", number, cpu_time_used);

	return 0;
}

bool isPrime(int n)
{
	if (n == 1) {
		return false;
	} else if (n < 4) {
		return true;
	} else if (n % 2 == 0) {
		return false;
	} else if (n < 9) {
		return true;
	} else if (n % 3 == 0) {
		return false;
	} else {
		int r = floor(sqrt(n));
		int f = 5;
		while (f <= r) {
			if (n % f == 0) {
				return false;
			} else if (n % (f + 2) == 0) {
				return false;
			}
			f += 6;
		}
		return true;
	}
}
