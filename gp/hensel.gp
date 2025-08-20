
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
