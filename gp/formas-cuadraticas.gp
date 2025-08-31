/* Algunas funciones propias de pari:
 * abs, gcd, apply, listput, length, setminus, isprime, Mod, List, Set
 */

Unidades(D) = {
	/* Devuelve la lista de clases de congruencia de enteros coprimos
	 * con D
	 */
	local( U = List([]) );
	for ( x = 1, abs(D)-1, if( gcd(x,D) == 1, listput( U, Mod(x,D) ) ) );
	return( Set(U) );
}

Residuos(D) = {
	/* Devuelve la lista de clases de congruencia de residuos mod D */
	\\ local ( R = List([]) );
	\\ for ( x = 1, abs(D) - 1, if ( gcd(x,D) == 1, listput( R, Mod(x^2,D) ) ) );
	\\ return ( Set(R) );
	local ( R = apply(x->x^2, Unidades(D)) );
	return( Set(R) );
}

discriminante(f) = {
	/* Devuelve el discriminante de una forma cuadrática.
	 * Asume que f está dada por una terna [a,b,c].
	 */
	return ( f[2] ^ 2 - 4 * f[1] * f[3] );
}

contenido(f) = {
	return ( gcd ( f ) );
}

es_primitiva(f) = {
	return ( contenido ( f ) == 1 );
}

forma_principal(D) = {
	if ( D % 4 == 0, \
		return ( [1, 0, -D / 4] ), \
		return ( [1, 1, -(1 - D) / 4] ) );
}

evaluar(x, y, f) = {
	/* Devuelve el valor de la forma f en el par (x,y).
	 * Asume que la forma f está dada por una terna [a,b,c].
	 */
	return ( f[1] * x ^ 2 + f[2] * x * y + f[3] * y ^ 2 );
}

actuar(f,M) = {
	/* Si M = [r,s;t,u], f = [a,b,c], devuelve la forma
	 * (fM)(x,y) = f(rx+sy,tx+uy)
	 */
	local ( A, B, C );
	A = evaluar(M[1,1], M[2,1], f);
	C = evaluar(M[1,2], M[2,2], f);
	B = evaluar(M[1,1] + M[1,2], M[2,1] + M[2,2], f) - A - C;
	return ( [A,B,C] );
}

vecino(f) = {
	/* Si f = [a,b,c] de discriminante b^2-4ac > 0 (no cuadrado),
	 * devuelve la forma ``vecina a la derecha'' de f.
	 */
	local ( A, B, C, D );
	D = discriminante(f);
	A = f[3];
	B = lift ( Mod(-f[2],2*A) );
	while ( B^2 >= D, \
		B -= abs(2*A);
	);
	while ( (B + abs(2*A))^2 < D, \
		B += abs(2*A);
	);
	C = (B^2 - D) / 4 / A;
	return ( [A,B,C] );
}

reducidas_definidas(D) = {
	/* returns the complete list of reduced primitive
	 * positive definite binary quadratic forms of
	 * discriminant D
	 */
	local ( a, b, c, d );
	local ( bound = abs(D) / 3 );
	local ( L = List([]) );
	a = 1;
	while ( a^2 <= bound,
		if ( ((d = - D) % (4*a)) == 0,
			c = d / 4 / a;
			if ( a <= c && es_primitiva([a,c]), listput(L,[a,0,c]) );
		);
		for ( b = 1, a-1,
			if ( ((d = b^2 - D) % (4*a)) == 0,
				c = d / 4 / a;
				if ( a <= c && es_primitiva([a,b,c]),
					if ( a < c,
						listput(L, [a,-b,c]);
					);
					listput(L, [a,b,c]);
				);
			);
		);
		if ( ((d = a^2 - D) % (4*a)) == 0,
			c = d / 4 / a;
			if ( a <= c && es_primitiva([a,c]), listput(L, [a,a,c]) );
		);
		a += 1;
	);
	return ( L );
}

print_vecinos_up_to(f,N) = {
	local ( g = f );
	printp(g);
	for ( i = 1, N, g = vecino(g); printp(g) );
}
/*
f = [1,1,-4];
print_vecinos_up_to(f,9);
*/

reducidas_indefinidas(D) = {
	local ( d = floor(sqrt(D)) );
	local ( amin = 1 ); \\ ceil((sqrt(D) - d) / 2) );
	local ( amax = d ); \\ floor((sqrt(D) + d) / 2) );
	local ( a, b, c );
	local ( L = List([]) );
	for ( a = amin, amax, \
		local ( bmin = ceil(abs(sqrt(D)-abs(2*a))) );
		local ( bmax = d );
		for ( b = bmin, bmax, \
			\\ printp([a,b]);
			if ( Mod(b,2) == Mod(D,2) && \
				Mod(b,4*a)^2 == Mod(D,4*a), \
				local ( c = (b^2 - D) / 4 / a );
				listput(L, [a,b,c]);
			 );
		);
	);
	return ( L );
}
/*
D = 29;
reducidas_indefinidas(D);
*/

reducidas(D) = {
	if ( Mod(D,4) == 0 || Mod(D,4) == 1, \
		if ( D < 0, return ( reducidas_definidas(D) ) );
		if ( D > 0, return ( reducidas_indefinidas(D) ) );
	);
}

clases(D) = {
	if ( Mod(D,4) == 0 || Mod(D,4) == 1, \
		if( D < 0, return ( length(reducidas(D)) ) );
		\\ if ( D > 0, return ( 2 * length(reducidas(D)) ) );
	);
}


