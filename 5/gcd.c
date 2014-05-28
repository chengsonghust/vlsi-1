/*
 *      Author:  Jordan Bayles (baylesj), baylesj@engr.orst.edu
 *     Created:  05/23/14 13:27:40
 *    Filename:  gcd.c
 *
 * Description:  Produces Golden Vector for use with gates GCD
 */

#include <stdio.h>
#include <stdlib.h>

#define INPUT "./vectors/input_data"
#define OUTPUT "./vectors/golden_data"

#define is_even(a) (((a) & 1) == 0)
#define array_len(a) ((sizeof(a))/(sizeof((a)[0])))

struct data {
	unsigned int a;
	unsigned int b;
	unsigned int gcd;
};

unsigned int find_gcd(struct data *in)
{
	int shift;
	unsigned int a;
	unsigned int b;

	a = in->a;
	b = in->b;

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
	in->gcd = a << shift;
	return in->gcd;
}

void stream_gcd()
{
	FILE *in;
	FILE *out;

	in = fopen(INPUT, "r");
	if (in == NULL) {
		return;
	}

	out = fopen(OUTPUT, "w");
	if (out == NULL) {
		return;
	}

	struct data cur;
	while (fscanf(in, "%d %d", &cur.a, &cur.b) > 0) {
		find_gcd(&cur);
		fprintf(out, "a_in: %d, b_in %d, result = %d\n",
		        cur.a, cur.b, cur.gcd);
	}

	fclose(in);
	fclose(out);
}

int main(int argc, char **argv)
{
	stream_gcd();

	return 0;
}
