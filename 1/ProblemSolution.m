classdef ProblemSolution
	properties
		T, Phi0, Phi1, Phi2, U1, U2, X1, X2,
		N, U_phi_num,
		X_last_num,
		Tmin, U_min_num,
		Solvability,
		TransversalityError,
		NeedPhi, GotPhi,
		EndAngleCos;
	end
	
	methods
		function obj = ProblemSolution()
			obj;
		end
	end
end
