function [J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(psi0, psi1, psi2)
	global Tv N options gamma

	sw = 0;

	[~, result] = ode45(@control_system, Tv, [0; 0; psi0; psi1; psi2], options);
	
	x1 = result(:, 1);
	x2 = result(:, 2);
	vpsi0 = result(:, 3);
	vpsi1 = result(:, 4);
	vpsi2 = result(:, 5);
	u1 = zeros(N, 1);
	u2 = zeros(N, 1);
	
	for i = 1 : N
		u1(i) = get_u1(vpsi0(i), vpsi1(i), vpsi2(i));
		u2(i) = get_u2(vpsi0(i), vpsi1(i), vpsi2(i), x1(i), x2(i));
	end
	
	for i = 2 : N
		if (vpsi1(i - 1) + vpsi2(i - 1) * x2(i - 1)) * (vpsi1(i) + vpsi2(i) * x2(i)) < 0
			sw = sw + 1;
		end
		if ((gamma * vpsi0(i - 1) - 2 * vpsi1(i - 1) - vpsi2(i - 1)) / (2 * vpsi0(i - 1))) * ((gamma * vpsi0(i) - 2 * vpsi1(i) - vpsi2(i)) / (2 * vpsi0(i))) < 0
			sw = sw + 1;
		end
	end
	
	J = trapz(Tv, u1.^2 + abs(u1));
end
