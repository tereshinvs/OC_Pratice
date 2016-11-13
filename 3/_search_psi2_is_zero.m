function [t_star, x, y] = search_psi2_is_zero(t, x_xi, y_xi, S)
	global N EPS options_psi2;
	t_star = t(1);
	x = x_xi;
	y = y_xi;
	if t(end) - t(1) < 1e-2
		return;
	end
	if isequal(S, @S_plus) == 1
		[~, res] = ode113(S, t, [x_xi; y_xi; -1.0; 0.0], options_psi2);
		[t_star, x, y] = search_psi2_is_zero(t(i - 1) : (t(i) - t(i - 1)) / N : t(i), res(i - 1, 1), res(i - 1, 2), S);
		t_star = t(end);
		x = res(end, 1);
		y = res(end, 2);
	else
		[~, res] = ode113(S, t, [x_xi; y_xi; 1.0; 0.0], options_psi2);
		for i = 3 : size(res, 1)
			if res(i, 4) < 0 && res(i, 3) > EPS
				[t_star, x, y] = search_psi2_is_zero(t(i - 1) : (t(i) - t(i - 1)) / N : t(i), res(i - 1, 1), res(i - 1, 2), S);
				return;
			end
		end
		t_star = t(end);
		x = res(end, 1);
		y = res(end, 2);
	end
end