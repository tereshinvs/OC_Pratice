function val = get_J(Tv, N, k1, k2, gamma, L, EPS, u1, u2)
	x = get_X(Tv, N, u1, u2);
	i = 1 : N;
	if abs(x(N, 1) - L) < EPS & abs(x(N, 2)) < EPS
		val = trapz(Tv, u1.^2 + gamma .* abs(u1));
	else
		val = Inf;
	end
end