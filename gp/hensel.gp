
polevalua(pol, a) = {
	/* pol = [f, indet]
	 * Returns value of f(a)
	 */
	local ( f = pol[1] );
	local ( indet = pol[2] );
	return ( subst(f, indet, a) );
}

polderiva(pol) = {
	/* pol = [f, indet]
	 * Returns f' with respect to indet
	 */
	local ( f = pol[1] );
	local ( indet = pol[2] );
	return ( [deriv(f, indet), indet] );
}

lift_once(pol, s) = {
	/* Polynomial pol is given as a pair [f, indet],
	 * where f is an polynomial expression in indet.
	 * Assumes Mod(f(a),p^j) == 0.
	 * Finds sol such that
	 * Mod(f(sol),p^(j+1)) == 0 && Mod(sol,p^j) == Mod(a,p^j).
	 */
	local ( a = s[1] );
	local ( p = s[2] );
	local ( j = s[3] );
	local ( from = p^j );
	local ( to = p*from );
	local ( b = Mod(polevalua(polderiva(pol), a), p) );
	local ( t = lift(b^(-1) * (-lift(polevalua(pol, Mod(a,to))) / from)) );
	return ( [a + from*t, p, j+1] );
}

lift_solutions(pol, L, from, upto) = {
	/* in : {
	 * pol : a polynomial given as a pair [f, indet];
	 * L : a list of solutions to Mod(f(a),p^j)==0
	 * (elements of L are s=[a,p,j]);
	 * from, upto : nonnegative integers.
	 * }
	 * out : a list of solutions to Mod(f(x),p^upto)==0
	 * such that Mod(x,p^from)==Mod(a,p^from) for some [a,p,j] in L.
	 */
	 local ( l = length(L) );
	 local ( s, a, p );
	 for ( j = from, upto, \
		 for ( i = 0, l - 1, \
		 	s = listpop(L);
			a = s[1];
			p = s[2];
			for ( t = 0, p - 1, \
			);
		);
	);
	 return ( L );
}

