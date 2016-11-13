classdef X1Class
	properties
		a;
	end
	
	methods
		function obj = X1Class(ta)
			obj.a = ta;
		end
		
		function [value, x_star] = support_function(obj, x)
			left = (obj.a - sqrt(obj.a^2 - 4)) / 2.0;
			right = (obj.a + sqrt(obj.a^2 - 4)) / 2.0;

			left_tan = -1.0 / left^2;
			right_tan = -1.0 / right^2;

			A = [left_tan; -1.0];
			B = [right_tan; -1.0];
	
			if vector_mult(A, x) >= 0 && vector_mult(x, B) >= 0
				lambda = [sqrt(x(1) * x(2)); -sqrt(x(1) * x(2))];
				x0 = -x(1) ./ lambda;
				y0 = -x(2) ./ lambda;
				if x0(1) >= 0
					x_star = [x0(1); y0(1)];
				else
					x_star = [x0(2); y0(2)];
				end
			elseif vector_mult(x, A) >= 0 && vector_mult([1 1], x) >= 0
				x_star = [left; 1.0 / left];
			else
				x_star = [right; 1.0 / right];
			end
		
			value = x.' * x_star;
		end
		
		function [x, y] = get_border(obj, STEP)
			left = (obj.a - sqrt(obj.a^2 - 4)) / 2.0;
			right = (obj.a + sqrt(obj.a^2 - 4)) / 2.0;
	
			x1 = left : STEP : right;
			y1 = 1 ./ x1;
	
			x2 = right : -STEP : left;
			y2 = obj.a - x2;
	
			x = [x1.'; x2.'];
			y = [y1.'; y2.'];
		end
		
		function res = is_inside(obj, x)
			global EPS;
			eps = EPS.TOUCHING_X1;
			res = x(1) + eps >= 0 && x(1) * x(2) >= 1 - eps && x(1) + x(2) <= obj.a + eps;
		end
		
		function res = normal(obj, x)
			global EPS;
			if abs(x(1) * x(2) - 1.0) < 1e-1
				res = [-1/x(1)^2; -1.0];
			else
				res = [1; 1];
			end
			res = res ./ norm(res);
		end
	end
end
