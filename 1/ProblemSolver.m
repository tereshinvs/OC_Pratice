classdef ProblemSolver
	properties
		A, B, t0, Q, p, a, alpha1, alpha2, X0, X1, P,
		npoints, Tmax, time_stemp,
	end
	
	methods
		function obj = ProblemSolver(tA, tB, tt0, tQ, tp, ta, talpha1, talpha2, tX0, tX1, tP, tnpoints, tTmax, ttime_stemp)
			obj.A = tA;
			obj.B = tB;
			obj.t0 = tt0;
			obj.Q = tQ;
			obj.p = tp;
			obj.a = ta;
			obj.alpha1 = talpha1;
			obj.alpha2 = talpha2;
			obj.X0 = tX0;
			obj.X1 = tX1;
			obj.P = tP;
			obj.npoints = tnpoints;
			obj.Tmax = tTmax;
			obj.time_stemp = ttime_stemp;
		end
		
		function res = is_specific_mode(obj, vs)
			global EPS;
			eps = EPS.SPECIFIC_MODE;
			for i = 2 : size(vs, 2)
				if norm(vs(:, i - 1)) < eps && norm(vs(:, i)) < eps
					disp('specific mode');
					res = 1;
					return;
				end
			end
			res = 0;
		end
		
		function res = is_intersection(obj)
			STEP = 1e-2;
			[x, y] = obj.X0.get_border(STEP);
			for i = 1 : size(x, 1)
				if obj.X1.is_inside([x(i); y(i)])
					res = 1;
					return;
				end
			end
			[x, y] = obj.X1.get_border(STEP);
			for i = 1 : size(x, 1)
				if obj.X0.is_inside([x(i); y(i)])
					res = 1;
					return;
				end
			end
			res = 0;
		end
		
		function sol = solve(obj)
			sol = obj.solve_system(0 : ((2 * pi) / obj.npoints) : (2 * pi));
		end
		
		function sol = clarify(obj, old_sol)
			best_phi = old_sol.Phi0(old_sol.U_phi_num(old_sol.U_min_num));
			delta_angle = (old_sol.Phi0(end) - old_sol.Phi0(1)) / 6.0;
			left_phi = best_phi - delta_angle;
			right_phi = best_phi + delta_angle;
			sol = obj.solve_system(left_phi : ((right_phi - left_phi) / obj.npoints) : right_phi); 
		end
		
		function sol = solve_system(obj, phi0)
			global EPS;
			
			sol = ProblemSolution();
			
			if obj.is_intersection() == 1
				sol.Solvability = 1;
				sol.Tmin = 0;
				return;
			end
			
			Amat = AClass(obj.A);
			sol.T = obj.t0 : obj.time_stemp : obj.Tmax;
			
			Bt = zeros(2, 2 * size(sol.T, 2));
			Bmat = zeros(2, 2 * size(sol.T, 2));
			for i = 1 : size(sol.T, 2)
				t = sol.T(i);
				Bmat(:, (i * 2 - 1) : (i * 2)) = eval(obj.B);
				Bt(:, (i * 2 - 1) : (i * 2)) = Bmat(:, (i * 2 - 1) : (i * 2)).';
			end
			
			sol.Phi0 = phi0;
			sin_phi = sin(phi0);
			cos_phi = cos(phi0);

			% Solving phi' = -A^T phi
			
			sol.Phi1 = zeros(size(sol.T, 2), size(phi0, 2));
			sol.Phi2 = zeros(size(sol.T, 2), size(phi0, 2));

			options = odeset('RelTol', EPS.REL_TOL, 'AbsTol', EPS.ABS_TOL);
			for i = 1 : size(phi0, 2)
				[~, phi] = ode45(@(t, x) (Amat.minus_A_transposed(t) * x), sol.T, [cos_phi(i) sin_phi(i)], options);
				sol.Phi1(:, i) = phi(:, 1);
				sol.Phi2(:, i) = phi(:, 2);				
			end
			disp('phi counted');
			
			% Getting u. It may be a lot of u for every phi series

			Btphi = zeros(2, size(sol.T, 2));

			for i = 1 : size(sol.Phi1, 2)
				phi = [sol.Phi1(:, i), sol.Phi2(:, i)].';
				for j = 1 : size(sol.T, 2)
					Btphi(:, j) = Bt(:, (j * 2 - 1) : (j * 2)) * phi(:, j);
				end
				
				tmpu = zeros(size(sol.T, 2), 2);
				if ~obj.is_specific_mode(Btphi)
					for j = 1 : size(sol.T, 2)
						[~, tmpu(j, :)] = obj.P.support_function(Btphi(:, j));
					end
				else
					for j = 1 : size(sol.T, 2)
						if norm(Btphi(:, j)) < EPS.SPECIFIC_MODE
							Btphi(:, j) = Btphi(:, j) + EPS.B_DEVIATION * phi(:, j);
						end
						[~, tmpu(j, :)] = obj.P.support_function(Btphi(:, j));
					end
				end
				sol.U1 = [sol.U1, tmpu(:, 1)];
				sol.U2 = [sol.U2, tmpu(:, 2)];
				sol.U_phi_num = [sol.U_phi_num; i];
			end
			sol.N = size(sol.U_phi_num, 1);
			disp('u counted');
			
			% Getting x for every u

			sol.X1 = zeros(size(sol.T, 2), size(sol.U1, 2));
			sol.X2 = zeros(size(sol.T, 2), size(sol.U1, 2));
			
			for i = 1 : sol.N
				tmpx = zeros(size(sol.T, 2), 2);
				[~, temp] = obj.X0.support_function([sol.Phi1(1, sol.U_phi_num(i)); sol.Phi2(1, sol.U_phi_num(i))]);
				tmpx(1, :) = temp.';
				for j = 1 : (size(sol.T, 2) - 1)
					tmpx(j + 1, :) = tmpx(j, :) + ...
						((Amat.get_value(sol.T(j)) * tmpx(j, :).').' + ...
						(Bmat(:, (j * 2 - 1) : (j * 2)) * [sol.U1(j, i); sol.U2(j, i)]).') * (sol.T(j + 1) - sol.T(j));
				end
				sol.X1(:, i) = tmpx(:, 1);
				sol.X2(:, i) = tmpx(:, 2);
			end
			disp('x counted');

			% Counting last point before intersection with X1
			
			sol.X_last_num = zeros(size(sol.X1, 2));
			
			for i = 1 : sol.N
				sol.X_last_num(i) = size(sol.X1, 1);
				for j = 1 : size(sol.T, 2)
					if obj.X1.is_inside([sol.X1(j, i); sol.X2(j, i)])
						sol.X_last_num(i) = j;
						break;
					end
				end
			end
			
			% Finding min
			
			sol.U_min_num = -1;
			sol.Tmin = obj.Tmax;
			sol.Solvability = 0;

			for i = 1 : sol.N
				if sol.Tmin > sol.T(sol.X_last_num(i)) - obj.t0 && obj.X1.is_inside([sol.X1(sol.X_last_num(i), i); sol.X2(sol.X_last_num(i), i)])
					sol.U_min_num = i;
					sol.Tmin = sol.T(sol.X_last_num(i)) - obj.t0;
					sol.Solvability = 1;
				end
			end
			
			% Transversality error
			
			if sol.Solvability == 1
				num = sol.U_min_num;
				last = sol.X_last_num(num);
				phi_t1 = [sol.Phi1(last, sol.U_phi_num(num)); sol.Phi2(last, sol.U_phi_num(num))];
				x_t1 = [sol.X1(last, num); sol.X2(last, num)];
				[value, x_star] = obj.X1.support_function(-phi_t1);
				sol.TransversalityError = abs(value - (-phi_t1)' * x_t1);
				sol.NeedPhi = obj.X1.normal([sol.X1(last, num); sol.X2(last, num)]);
				sol.GotPhi = -[sol.Phi1(last, sol.U_phi_num(num)); sol.Phi2(last, sol.U_phi_num(num))];
				sol.GotPhi = sol.GotPhi ./ norm(sol.GotPhi);
				sol.EndAngleCos = sol.NeedPhi.' * sol.GotPhi;
			end
		end
	end
end
