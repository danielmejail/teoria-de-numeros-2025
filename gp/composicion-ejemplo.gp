\\ Ejemplo de composición de formas (p. 34, Cox)

dirichlet_composable(f,g) = {
	if ( discriminante(f) == discriminante(g), \
		if ( gcd ( [f[1], g[1], (f[2]+g[2])/2] ) == 1, \
			return ( 1 ) ) );
	return ( 0 );
}

dirichlet_compose(f,g) = {
	/* Returns Dirichlet composition of f and g,
	 * if Dirichlet composable;
	 */
	local ( D = discriminante(f) );
	local ( B ); \\ middle coefficient of Dirichlet composition
	/* must satisfy
	 * abs(B) <= f[1]*g[1] (B is unique mod 2*f[1]*g[1])
	 * B == Mod(f[2],2*f[1]);
	 * B == Mod(g[2],2*g[1]);
	 * B^2 == Mod(D,4*f[1]*g[1]);
	 */
	L = List([]);
	B = f[2];
	while ( B <= 2*f[1]*g[1], \
		listput(L, B);
		B += 2*f[1];
	);
	B = f[2] - 2*f[1];
	while ( B > 2*f[1]*g[1], \
		listput(L, B);
		B -= 2*f[1];
	);
	for ( i = 1, length(L), \
		B = L[i];
		if ( (B != Mod(g[2], 2*g[1])) || \
			(B^2 != Mod(D, 4*f[1]*g[1])), listpop(L,i) );
	);
}
A = [1,0,41];
B = [2,2,21];
C = [5,4,9];
D = [3,2,14];
E = [6,2,7];

L = List([A,B,C,D,E]);

for ( i = 1, length(L), \
	for ( j = i, length(L), \
		

