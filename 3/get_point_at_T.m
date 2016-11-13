function [x, y] = get_point_at_T(xi, x_xi, y_xi, T, S, n)
	global EPS X_switch_ Y_switch_ options_psi2_to_neg options_psi2_to_pos;

	if abs(xi - T) < EPS
		x = x_xi;
		y = y_xi;
		return;
	end
	
	X_switch_ = [X_switch_; x_xi];
	Y_switch_ = [Y_switch_; y_xi];

	if isequal(S, @S_plus) == 1
		[t, res, TE, YE, IE] = ode113(S, [xi T], [x_xi; y_xi; -1.0; 0.0], options_psi2_to_neg);
		num = size(t, 1);
		if abs(t(num) - T) < EPS
			x = res(num, 1);
			y = res(num, 2);
			return;
		else
			[x, y] = get_point_at_T(t(num), res(num, 1), res(num, 2), T, @S_minus, n + 1);
		end
	else
		[t, res, TE, YE, IE] = ode113(S, [xi T], [x_xi; y_xi; 1.0; 0.0], options_psi2_to_pos);
		num = size(t, 1);
		if abs(t(num) - T) < EPS
			x = res(num, 1);
			y = res(num, 2);
			return;
		else
			[x, y] = get_point_at_T(t(num), res(num, 1), res(num, 2), T, @S_plus, n + 1);
		end
	end
end
