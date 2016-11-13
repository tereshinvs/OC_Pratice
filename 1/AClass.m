classdef AClass
	properties
		mat;
	end
	
	methods
		function obj = AClass(tmat)
			obj.mat = tmat;
		end
		
		function res = get_value(obj, t)
			res = eval(obj.mat);
		end
		
		function res = minus_A_transposed(obj, t)
			res = -(eval(obj.mat)).';
		end
	end
end
