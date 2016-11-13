function [X, Y, X_switch, Y_switch] = reachset(alpha, T)
	global alpha_ EPS X_switch_ Y_switch_ N options_psi2_to_neg options_psi2_to_pos;
	alpha_ = alpha;
	
	options_x2_to_neg = odeset('RelTol', 1e-6, 'AbsTol', [1e-6 1e-6 1e-6 1e-6], 'Event', @x2_is_zero_event_to_neg);
	options_x2_to_pos = odeset('RelTol', 1e-6, 'AbsTol', [1e-6 1e-6 1e-6 1e-6], 'Event', @x2_is_zero_event_to_pos);
	options_psi2_to_neg = odeset('RelTol', 1e-6, 'AbsTol', [1e-6 1e-6 1e-6 1e-6], 'Event', @psi2_is_zero_event_to_neg);
	options_psi2_to_pos = odeset('RelTol', 1e-6, 'AbsTol', [1e-6 1e-6 1e-6 1e-6], 'Event', @psi2_is_zero_event_to_pos);
	N = 10;
	EPS = 1e-6;

	X = [];
	Y = [];
	X_switch = [];
	Y_switch = [];
	X_switch_ = [];
	Y_switch_ = [];
	
	[t, res, TE, YE, IE] = ode113(@S_plus, [0 T], [0; 0; 0; 0], options_x2_to_neg);
	num = size(t, 1)
	for i = 1 : num
		[tmpx, tmpy] = get_point_at_T(t(i), res(i, 1), res(i, 2), T, @S_minus, 1);
		X = [X; tmpx];
		Y = [Y; tmpy];
	end

	[t, res, TE, YE, IE] = ode113(@S_minus, [0 T], [0; 0; 0; 0], options_x2_to_pos);
	num = size(t, 1)
	for i = 1 : num
		[tmpx, tmpy] = get_point_at_T(t(i), res(i, 1), res(i, 2), T, @S_plus, 1);
		X = [X; tmpx];
		Y = [Y; tmpy];
	end
	
	tmp = sortrows([X_switch_, Y_switch_], 1);
	%if alpha < 1.0
		X_switch = tmp(:, 1);
		Y_switch = tmp(:, 2);
		alr_chg = 0;
		while true
			i = 2;
			chg = 0;
			while i < size(X_switch, 1) - alr_chg
				if abs(Y_switch(i) - Y_switch(i - 1)) > 0.2 && abs(Y_switch(i) - Y_switch(i + 1)) > 0.2 || ...
					abs(Y_switch(i) - Y_switch(i - 1)) > 0.2 && abs(Y_switch(i + 1) - Y_switch(i - 1)) > 0.2
					X_switch = [X_switch(1 : i - 1); X_switch(i + 1 : end - alr_chg); X_switch(i); X_switch(end - alr_chg + 1 : end)];
					Y_switch = [Y_switch(1 : i - 1); Y_switch(i + 1 : end - alr_chg); Y_switch(i); Y_switch(end - alr_chg + 1 : end)];
					chg = chg + 1;
					alr_chg = alr_chg + 1;
					if i > 2
						i = i - 1;
					end
				else
					i = i + 1;
				end
			end
			if chg == 0
				break;
			end
		end
	%else
	%	X_switch = tmp(:, 1);
	%	Y_switch = tmp(:, 2);
	%end
	
	[X, Y] = remove_intersection(X, Y);
end
