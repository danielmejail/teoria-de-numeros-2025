primes_congruent_to(c, m, B, b=1, L=List([])) = {
	/* c : a congruence class mod m
	 * m : a positive integer
	 * B : a bound
	 * b : an optional lower bound 
	 * L : a list of previously computed primes
	 */
	for ( x = b, B, if ( (x % m == c) && isprime(x), listput(L,x) ) );
	return ( L );
}

