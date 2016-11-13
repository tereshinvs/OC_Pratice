classdef PClass
	properties
		Q, A, p;
	end
	
	methods
		function obj = PClass(tQ, tp)
			obj.Q = eval(tQ);
			obj.p = tp;
			obj.A = inv(obj.Q);
		end
		
		function [value, u_star] = support_function(obj, x)
			global EPS;
			eps = EPS.ZERO_IN_IMAG_TESTING;
			
			if norm(x) < eps
				value = 0;
				u_star = [0; 0];
				return;
			end
			
			a = obj.A(1, 1);
			b = obj.A(2, 2);
			c = obj.A(1, 2) + obj.A(2, 1);
			d = -2 * obj.A(1, 1) * obj.p(1) - obj.p(2) * (obj.A(1, 2) + obj.A(2, 1));
			e = -2 * obj.A(2, 2) * obj.p(2) - obj.p(1) * (obj.A(1, 2) + obj.A(2, 1));
			f = obj.A(1, 1) * obj.p(1)^2 + obj.p(1) * obj.p(2) * (obj.A(1, 2) + obj.A(2, 1)) + obj.A(2, 2) * obj.p(2)^2 - 1;

			xs = [ ...
				-(2*b*d - c*e - 2*b*x(1)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2) + c*x(2)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2))/(- c^2 + 4*a*b); ...
				-(2*b*d - c*e + 2*b*x(1)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2) - c*x(2)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2))/(- c^2 + 4*a*b) ...
			];

			ys = [ ...
				-(2*a*e - c*d - 2*a*x(2)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2) + c*x(1)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2))/(- c^2 + 4*a*b); ...
				-(2*a*e - c*d + 2*a*x(2)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2) - c*x(1)*((f*c^2 - c*d*e + b*d^2 + a*e^2 - 4*a*b*f)/(b*x(1)^2 - c*x(1)*x(2) + a*x(2)^2))^(1/2))/(- c^2 + 4*a*b) ...
			];
		
			values = xs * x(1) + ys * x(2);
			[value, i] = max(values);
			u_star = [xs(i); ys(i)];
		end
		
		function [x, y] = get_border(obj, STEP)
			phi = 0 : STEP : (2.0 * pi);
			cos_phi = cos(phi);
			sin_phi = sin(phi);
			
			pho = (obj.A(1, 1) * cos_phi.^2 + obj.A(2, 2) * sin_phi.^2 + (obj.A(1, 2) + obj.A(2, 1)) .* sin_phi .* cos_phi) .^ (-0.5);

			x = pho .* cos_phi + obj.p(1);
			y = pho .* sin_phi + obj.p(2);
		end
	end
end
