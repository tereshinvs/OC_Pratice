function x = get_X(Tv, N, u1, u2)
	x = zeros(N, 2);
	for i = 2 : N
		x(i, 1) = x(i - 1, 1) + (x(i - 1, 2) + u2(i - 1) + 2 * u1(i - 1)) * (Tv(i) - Tv(i - 1));
		x(i, 2) = x(i - 1, 2) + (u1(i - 1) + u2(i - 1) * x(i - 1, 2)) * (Tv(i) - Tv(i - 1));
	end
end