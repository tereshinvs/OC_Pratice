global T k1 k2 gamma L EPS dt Tv N options

T = 10;
k1 = 0.1;
k2 = 0.2;
gamma = 0.5;
L = -50;
EPS = 2;

dt = 1e-1;

res_u1 = [];
res_u2 = [];
res_J = Inf;
res_sw = Inf;
res_vpsi0 = [];
res_vpsi1 = [];
res_vpsi2 = [];

Tv = 0 : dt : T;
N = size(Tv, 2);

dtheta = 5e-2;
dphi = 5e-2;
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-4 1e-4 1e-4]);

hold on;
for theta = 0 : dtheta : pi
	for phi = 0 : dphi : (2 * pi)
		psi0 = cos(theta);
		psi1 = sin(theta) * cos(phi);
		psi2 = sin(theta) * sin(phi);
		if psi0 <= 0
			[J, sw, x1, x2, u1, u2, vpsi0, vpsi1, vpsi2] = solve_system(psi0, psi1, psi2);
			plot(x1, x2);
			if abs(x1(end) - L) < EPS && abs(x2(end)) < EPS && J < res_J
				res_J = J;
				res_u1 = u1;
				res_u2 = u2;
				res_x1 = x1;
				res_x2 = x2;
				res_vpsi0 = vpsi0;
				res_vpsi1 = vpsi1;
				res_vpsi2 = vpsi2;
				res_sw = sw;
			end
		end
	end
end

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

