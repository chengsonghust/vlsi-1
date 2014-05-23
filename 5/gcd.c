/*
 *      Author:  Jordan Bayles (baylesj), baylesj@engr.orst.edu
 *     Created:  05/23/14 13:27:40
 *    Filename:  gcd.c
 *
 * Description:  Produces Golden Vector for use with gates GCD
 */

#include <stdio.h>
#include <stdlib.h>

#define is_even(a) (((a) & 1) == 0)

unsigned int gcd(unsigned int a, unsigned int b)
{
	int shift;

	// base cases gcd(0, 0) = 0, gcd(a, 0) = a, gcd(a, b) = b
	if (a == 0) {
		return b;
	} else if (b == 0) {
		return a;
	}

	// shift by shared factors of 2
	for (shift = 0; is_even(a | b); ++shift) {
		a >>= 1;
		b >>= 1;
	}

	// shift out unshared factors of 2
	while (is_even(a)) {
		a >>= 1;
	}

	while (b != 0) {
		// shift out unshared factors of 2
		while (is_even(b)) {
			b >>= 1;
		}

		// now both odd
		if (a > b) {
			// swap a and b
			unsigned int tmp = b;
			b = a;
			a = tmp;
		}

		// subtract
		b = b - a;
	}

	// shift by shared factors of two
	return a << shift;
}

int main(int argc, char **argv)
{
	printf("%d, %d -> %u\n", 10, 20, gcd(10, 20));

}
