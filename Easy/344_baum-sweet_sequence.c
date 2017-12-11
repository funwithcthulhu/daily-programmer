/*
Daily Programmer - Easy #344 - Baum-Sweet Sequence 

Description

In mathematics, the Baum–Sweet sequence is an infinite automatic
sequence of 0s and 1s defined by the rule:

b_n = 1 if the binary representation of n contains no block of consecutive
0s of odd length;

b_n = 0 otherwise;

for n >= 0.

For example, b_4 = 1 because the binary representation of 4 is 100, which
only contains one block of consecutive 0s of length 2; whereas b_5 = 0 because
the binary representation of 5 is 101, which contains a block of consecutive
0s of length 1. When n is 19611206, b_n is 0 because:

19611206 = 1001010110011111001000110 base 2
            00 0 0  00     00 000  0 runs of 0s
               ^ ^            ^^^    odd length sequences

Because we find an odd length sequence of 0s, b_n is 0.

Challenge Description

Your challenge today is to write a program that generates the Baum-Sweet sequence
from 0 to some number n. For example, given "20" your program would emit:

1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0
*/

// My solution uses the ordered set rules found here: https://oeis.org/A060142

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void baumSweet(int x, int limit, char *seq)
{
	if (x > limit)
		return;
	seq[x] = 1;
	baumSweet(2 * x + 1, limit, seq);
	baumSweet(4 * x, limit, seq);
}

int main(int argc, char *argv[])
{
	if (argc != 2) {
		fprintf(stderr, "Usage %s\n", argv[0]);
		return 1;
	}
	char *l;
	int limit = strtol(argv[1], &l, 10) + 1;
	char seq[limit];
	memset(seq, 0, limit);
	seq[0] = 1;

	baumSweet(1, limit, seq);
	for (int i = 0; i < limit; i++) {
		printf("%i, ", seq[i]);
	}
	printf("\n");
	return 0;
}
