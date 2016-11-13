classdef EPSClass
	properties
		TOUCHING_X1,
		SPECIFIC_MODE,
		ZERO_IN_IMAG_TESTING,
		REL_TOL, ABS_TOL;
		B_DEVIATION;
	end
	
	methods
		function obj = EPSClass(tTOUCHING_X1, tSPECIFIC_MODE, tZERO_IN_IMAG_TESTING, tREL_TOL, tABS_TOL, tB_DEVIATION)
			obj.TOUCHING_X1 = tTOUCHING_X1;
			obj.SPECIFIC_MODE = tSPECIFIC_MODE;
			obj.ZERO_IN_IMAG_TESTING = tZERO_IN_IMAG_TESTING;
			obj.REL_TOL = tREL_TOL;
			obj.ABS_TOL = tABS_TOL;
			obj.B_DEVIATION = tB_DEVIATION;
		end
	end
end