
find_prime(m,D) = {
	if ( gcd(m,D) > 1, return ( 0 ) );
	while ( !(isprime(m)), m += 2*abs(D) );
	return ( m );
}

my_jacobi(M,N) = {
	if ( M < 0, return ( my_jacobi(N-1,N) * my_jacobi(abs(M),N) ) );
	if ( M > N, return ( my_jacobi( (M%N), N ) ) );
	if ( gcd(M,N) > 1, return ( 0 ) );
	return ( (-1)^(lift(additive_jacobi(M,N))) );
}

additive_jacobi(M,N) = {
	if ( M > N, return ( additive_jacobi( (M%N), N ) ) );
	if ( M == 1, return ( 0 ) );
	if ( M == N - 1, return ( Mod((N-1)/2,2) ) );
	if ( M == 2, return ( ( Mod((N^2-1)/8,2) ) ) );
	if ( M%4 == 0, return ( additive_jacobi( M/4, N ) ) );
	if ( M%2 == 0, return ( additive_jacobi( M/2, N ) + \
		additive_jacobi(2,N) ) );
	return ( additive_jacobi(N,M) + ( Mod((M-1)*(N-1)/4,2) ) );
}

my_kronecker(D,m) = {
	if ( gcd(D,m) > 1, return ( 0 ) );
	if ( m%2 == 0, return ( my_kronecker(D,m+D) ) );
	return ( my_jacobi(D,m) );
}

