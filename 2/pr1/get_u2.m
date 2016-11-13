function u2 = get_u2(psi0, psi1, psi2, x1, x2)
	global k1 k2

	if psi1 + psi2 * x2 >= 0
		u2 = k2;
	else
		u2 = k1;
	end
end