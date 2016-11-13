function res = segments_intersect(P1, P2, P3, P4)
	A = [P1(2) - P2(2), P2(1) - P1(1); ...
		P3(2) - P4(2), P4(1) - P3(1)];
	B = [P2(1) * P1(2) - P1(1) * P2(2); ...
		P4(1) * P3(2) - P3(1) * P4(2)];
	X = linsolve(A, B);
	res = point_is_between(X, P1, P2) == 1 && point_is_between(X, P3, P4) == 1;
end
