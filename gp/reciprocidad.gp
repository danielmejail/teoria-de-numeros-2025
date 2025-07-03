\r formas-cuadraticas.gp

clases_de_primos_representados(B, f, as_set = 1, D = discriminante(f)) = {
	/* Devuelve una lista con las clases de congruencia módulo
	 * discriminante(f) a las cuales pertenecen los primos
	 * representados por la forma f, de la forma f(x,y) con
	 * |x|, |y| <= B
	 * * sería apply(Mod(x,D), primos_representados)
	 */
	local ( L = List([]) );
	for ( x = -B, B, for ( y = -B, B, \
		if ( ( gcd(x,y) == 1 ) && ( isprime( p=evaluar(x, y, f) ) ), \
			listput( L, Mod(p, D) )
		) ) );
	if ( as_set, return ( Set(L) ) );
	return ( L );
}

clases_de_factores_de_representados(B, f, as_set = 1, D = discriminante(f)) = {
	/* Devuelve una lista con las clases de congruencia módulo
	 * discriminante(f) de los factores primos de los enteros
	 * representados por f de la forma f(x,y) con |x|, |y| <= B
	 * coprimos.
	 */
	local ( L = List([]) );
	for ( x = -B, B, for ( y = -B, B, \
		if ( gcd(x,y) == 1, \
			descomposicion = factor(evaluar(x,y,f));
			for ( i = 1, length(descomposicion~), \
				\\ p = descomposicion[i,1];
				listput( L, Mod(descomposicion[i,1], D) );
			) ) ) );
	if ( as_set, return ( Set(L) ) );
	return ( L );
}

primos_representados(B, f, as_classes = 0, as_set = 1, D = discriminante(f)) = {
	/* Devuelve una lista con los primos representados por la forma f,
	 * de la forma f(x,y) con |x|, |y| <= B
	 */
	local ( L = List([]) );
	for ( x = -B, B, for ( y = -B, B, \
		\\ if ( ( gcd(x,y) == 1 ) && ( isprime( p=evaluar(x, y, f) ) ), \
		if ( ( gcd(x,y) == 1 ) && ( isprime( p=evaluar(x, y, f) ) ) && ( Mod(D,p) != 0 ), \
			listput( L, p )
		) ) );
	if ( as_classes, L = apply( x->Mod(x,D), L ) );
	if( as_set, return ( Set(L) ) );
	return ( L );
}

factores_de_representados(B, f, as_classes = 0, as_set = 1, D = discriminante(f)) = {
	/* Devuelve una lista con los factores primos de los enteros
	 * representados por f de la forma f(x,y) con |x|, |y| <= B
	 * coprimos.
	 */
	local ( L = List([]) );
	for ( x = -B, B, for ( y = -B, B, \
		\\ if ( gcd(x,y) == 1, \
		if ( ( gcd(x,y) == 1)  && ( gcd(N=evaluar(x,y,f),D) == 1 ), \
			descomposicion = factor(evaluar(x,y,f));
			for ( i = 1, length(descomposicion~), \
				\\ p = descomposicion[i,1];
				listput( L, descomposicion[i,1] );
			) ) ) );
	if ( as_classes, L = apply( x->Mod(x,D), L ) );
	if ( as_set, return ( Set(L) ) );
	return ( L );
}


/*
primos_representados(15,[1,0,11])
primos_representados(15,[1,0,11],1)
factores_de_representados(15,[1,0,11])
factores_de_representados(15,[1,0,11],1)
primos_representados(20,[1,0,13])
primos_representados(20,[1,0,13],1)
primos_representados(40,[1,0,13],1)
factores_de_representados(40,[1,0,13],1)
setminus(factores_de_representados(40,[1,0,13],1), primos_representados(40,[1,0,13],1))
factores_de_representados(40,[1,0,15],1)
factores_de_representados(40,[1,0,17],1)
primos_representados(40,[1,0,17],1)
setminus(factores_de_representados(40,[1,0,17],1), primos_representados(40,[1,0,17],1))
discriminante([3,2,6])
primos_representados(40,[3,2,6],1)
primos_representados(40,[1,0,17],1)
primos_representados(40,[3,-2,6],1)
primos_representados(40,[6,-2,3],1)
primos_representados(40,[6,2,3],1)

length(Unidades(discriminante([1,0,17])))
length(factores_de_representados(40,[1,0,17],1))

n = 17;
length(Unidades(4*(-n))) / length(factores_de_representados(40,[1,0,n],1))
*/

