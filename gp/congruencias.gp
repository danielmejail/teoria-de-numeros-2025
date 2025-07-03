
soluciones_modulares(p, m) = {
	local ( S = List([]) );
	for ( x = 0, m - 1, if ( p(x) % m == 0, listput(S, x) ) );
	return ( S );
}

f(x) = x ^ 2 - 117 * x + 31;
B = 400;
for ( m = 2, B, if ( length(S=soluciones_modulares(f,m)) > 0, \
	print1(m); print1("\t"); print(S) ) );
\\ 5, 85, 115, 391, 2713

