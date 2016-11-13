global T k1 k2 gamma L EPS dt Tv N options

T = 5;
k1 = 0.1;
k2 = 0.2;
gamma = 1;
L = 1.2;
EPS = 0.1;

dt = 1e-1;

options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-4 1e-4 1e-4]);

res_u1 = [];
res_u2 = [];
res_J = Inf;
res_sw = Inf;
res_x1 = [];
res_x2 = [];

Tv = 0 : dt : T;
N = size(Tv, 2);

dpsi1_0 = 1e-1;
dpsi2_0 = 1e-1;
dtau = 1e-1;
dx2_1 = 1e-2;

hold on

%% psi1 < 0, u1 switches
disp('psi1 < 0, u1 switches');

for tau1 = 0 : dtau : T
	for x2_1 = 0 : dx2_1 : EPS
		A = [
			exp(-k1 * tau1) / k1 - 2 - 1 / k1, exp(-k1 * tau1); ...
			-exp(-k1 * tau1) / (2 * k1^2) + 1/(k1^2) - 2/k1 + 2 * exp(k1 * tau1)/k1 - exp(k1 * tau1)/(2 * k1^2), -exp(-k1 * tau1)/(2*k1) + exp(k1 * tau1)/(2*k2)
		];
		b = [-gamma/2; x2_1 - gamma / (2 * k1)];
		tmp = linsolve(A, b);
		psi1_0 = tmp(1);
		psi2_0 = tmp(2);

		[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(-0.5, psi1_0, psi2_0);
		plot(x1, x2);
		
		if abs(x1(N) - L) < EPS && abs(x2(N)) < EPS && J < res_J
			res_x1 = x1;
			res_x2 = x2;
			res_u1 = u1;
			res_u2 = u2;
			res_J = J;
			res_sw = sw;
			res_vpsi0 = vpsi0;
			res_vpsi1 = vpsi1;
			res_vpsi2 = vpsi2;
		end	
	end
end

%% psi1 < 0, u2 switches
disp('psi1 < 0, u2 switches');

for tau1 = 0 : dtau : T
	for x2_1 = 0 : dx2_1 : EPS
		A = [
			exp(-k1 * tau1) / k1 - 1 / k1 - 1 / x2_1, exp(-k1 * tau1); ...
			-exp(-k1 * tau1) / (2 * k1^2) + 1/(k1^2) - 2/k1 + 2 * exp(k1 * tau1)/k1 - exp(k1 * tau1)/(2 * k1^2), -exp(-k1 * tau1)/(2*k1) + exp(k1 * tau1)/(2*k2)
		];
		b = [0; x2_1 - gamma / (2 * k1)];
		tmp = linsolve(A, b);
		psi1_0 = tmp(1);
		psi2_0 = tmp(2);

		[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(-0.5, psi1_0, psi2_0);
		plot(x1, x2);
		
		if abs(x1(N) - L) < EPS && abs(x2(N)) < EPS && J < res_J
			res_x1 = x1;
			res_x2 = x2;
			res_u1 = u1;
			res_u2 = u2;
			res_J = J;
			res_sw = sw;
			res_vpsi0 = vpsi0;
			res_vpsi1 = vpsi1;
			res_vpsi2 = vpsi2;
		end	
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 0 < psi1 < gamma/2, no switches
disp('0 < psi1 < gamma/2, no switches');

for psi1_0 = 0 : dpsi1_0 : (gamma / 4)
	A = -exp(-k2 * T) / (2 * k2^2) + 2 * exp(k2 * T) / k2 - exp(k2 * T) / (2 * k2^2) - 1 / k2^2 - 2 / k2;
	B = -exp(-k2 * T) / (2 * k2) + exp(k2 * T) / (2 * k2);
	C = gamma / (2 * k2);
	D = psi1_0 * A + C;
	
	if B > 0
		vec = ((-EPS - D)/B) : dpsi2_0 : ((EPS - D)/B);
	else
		vec = ((EPS - D)/B) : dpsi2_0 : ((-EPS - D)/B);
	end
	for psi2_0 = vec
		%psi1_0
		%psi2_0
		[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(-0.5, psi1_0, psi2_0);
		plot(x1, x2);
		
		if abs(x1(N) - L) < EPS && abs(x2(N)) < EPS && J < res_J
			res_x1 = x1;
			res_x2 = x2;
			res_u1 = u1;
			res_u2 = u2;
			res_J = J;
			res_sw = sw;
			res_vpsi0 = vpsi0;
			res_vpsi1 = vpsi1;
			res_vpsi2 = vpsi2;
		end
	end
end

%% 0 < psi1 < gamma/2, 1 switch or 2 switches
disp('0 < psi1 < gamma/2, 1 switch or 2 switches');

for psi1_0 = 0 : dpsi1_0 : (gamma / 4)
	for tau1 = 0 : dtau : T
		psi2_t = gamma / 2 - 2 * psi1_0;
		C = (psi2_t + psi1_0 / k2) / exp(-k2 * tau1);
		psi2_0 = C - psi1_0 / k2;

		[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(-0.5, psi1_0, psi2_0);
		plot(x1, x2);
		
		if abs(x1(N) - L) < EPS && abs(x2(N)) < EPS && J < res_J
			res_x1 = x1;
			res_x2 = x2;
			res_u1 = u1;
			res_u2 = u2;
			res_J = J;
			res_sw = sw;
			res_vpsi0 = vpsi0;
			res_vpsi1 = vpsi1;
			res_vpsi2 = vpsi2;
		end
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% psi1 > gamma/4, u1 switches
disp('psi1 > gamma/4, u1 switches');

for tau1 = 0 : dtau : T
	for x2_1 = 0 : dx2_1 : EPS
		A = [
			exp(-k2 * tau1) / k2 - 2 - 1 / k2, exp(-k2 * tau1); ...
			-exp(-k2 * tau1) / (2 * k2^2) + 1/(k2^2) - 2/k2 + 2 * exp(k2 * tau1)/k2 - exp(k2 * tau1)/(2 * k2^2), -exp(-k2 * tau1)/(2*k2) + exp(k2 * tau1)/(2*k2)
		];
		b = [-gamma/2; x2_1 - gamma / (2 * k2)];
		tmp = linsolve(A, b);
		psi1_0 = tmp(1);
		psi2_0 = tmp(2);

		[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(-0.5, psi1_0, psi2_0);
		plot(x1, x2);
		
		if abs(x1(N) - L) < EPS && abs(x2(N)) < EPS && J < res_J
			res_x1 = x1;
			res_x2 = x2;
			res_u1 = u1;
			res_u2 = u2;
			res_J = J;
			res_sw = sw;
			res_vpsi0 = vpsi0;
			res_vpsi1 = vpsi1;
			res_vpsi2 = vpsi2;
		end	
	end
end

%% psi1 < 0, u2 switches
disp('psi1 > gamma/4, u2 switches');

for tau1 = 0 : dtau : T
	for x2_1 = 0 : dx2_1 : EPS
		A = [
			exp(-k2 * tau1) / k2 - 1 / k2 - 1 / x2_1, exp(-k2 * tau1); ...
			-exp(-k2 * tau1) / (2 * k2^2) + 1/(k2^2) - 2/k2 + 2 * exp(k2 * tau1)/k2 - exp(k2 * tau1)/(2 * k2^2), -exp(-k2 * tau1)/(2*k2) + exp(k2 * tau1)/(2*k2)
		];
		b = [0; x2_1 - gamma / (2 * k2)];
		tmp = linsolve(A, b);
		psi1_0 = tmp(1);
		psi2_0 = tmp(2);

		[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(-0.5, psi1_0, psi2_0);
		plot(x1, x2);
		
		if abs(x1(N) - L) < EPS && abs(x2(N)) < EPS && J < res_J
			res_x1 = x1;
			res_x2 = x2;
			res_u1 = u1;
			res_u2 = u2;
			res_J = J;
			res_sw = sw;
			res_vpsi0 = vpsi0;
			res_vpsi1 = vpsi1;
			res_vpsi2 = vpsi2;
		end	
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Results

plot(0, 0, 'Marker', '+', 'MarkerEdgeColor', [0 1 0], 'MarkerFaceColor', [0 1 0], 'MarkerSize', 20);
plot([L - EPS; L - EPS; L + EPS; L + EPS; L - EPS], [-EPS; EPS; EPS; -EPS; -EPS], 'g', 'LineWidth', 2);

if res_J < Inf
	plot(res_x1, res_x2, 'r');
	xlabel('x_1');
	ylabel('x_2');
	figure;
	plot(Tv, res_u1);
	xlabel('t');
	ylabel('u_1');
	figure;
	plot(Tv, res_u2);
	xlabel('t');
	ylabel('u_2');
	figure;
	plot(Tv, res_vpsi1);
	xlabel('t');
	ylabel('\psi_1');
	figure;
	plot(Tv, res_vpsi2);
	xlabel('t');
	ylabel('\psi_2');
	
	disp(['J = ' num2str(res_J)]);
	disp([num2str(res_sw) ' switches']);
else
	disp('Fail');
end
