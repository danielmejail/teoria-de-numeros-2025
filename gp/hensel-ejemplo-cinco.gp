
poleval(pol, a, indet=x) = {
	return ( subst(pol, indet, a) );
}

p = 5;
N = 4;
f = x^2-x+3;

/*
s1 = [0];

for ( i = 1, length( s1 ), \
	{
	a = s1[i];
	for ( t = 0, p-1, printp(
		[a, t, Mod(poleval(f,a) + t * poleval(f',a),p)] ) );
	} \
);

s5 = [s1[1]+2,s1[1]+4];

for ( i = 1, length( s5 ), \
	{
	a = s5[i];
	for ( t = 0, p-1, printp(
		[a, t, Mod(poleval(f,a) + p * t * poleval(f',a),p^2)] ) );
	} \
);

s25 = [s5[1]+p*3,s5[2]+p*1];

for ( i = 1, length( s25 ), \
	{
	a = s25[i];
	for ( t = 0, p-1, printp(
		[a, t, Mod(poleval(f,a) + p^2 * t * poleval(f',a),p^3)] ) );
	} \
);

s125 = [s25[1]+p^2*3,s25[2]+p^2*1];

for ( i = 1, length( s125 ), \
	{
	a = s125[i];
	for ( t = 0, p-1, printp(
		[a, t, Mod(poleval(f,a) + p^3 * t * poleval(f',a),p^4)] ) );
	} \
);

s625 = [s125[1]+p^3*1,s125[2]+p^3*3];

*/
/* --- */
g = f * (x+1);
s5 = [2,4];
for ( i = 1, length( s1 ), \
	{
	a = s5[i];
	for ( t = 0, p-1, printp(
		[a, t, Mod(poleval(g,a) + p * t * poleval(g',a),p^2)] ) );
	} \
);

s25 = [4,9,14,19,24];
s125 = [9,24];

