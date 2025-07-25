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

formas(D) = {
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

clases(D) = {
	return ( length(formas(D)) );
}
