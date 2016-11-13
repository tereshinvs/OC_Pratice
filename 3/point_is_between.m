function res = point_is_between(X, P1, P2)
	res = min([P1(1); P2(1)]) <= X(1) &&  X(1) <= max([P1(1); P2(1)]) && ...
		min([P1(2); P2(2)]) <= X(2) &&  X(2) <= max([P1(2); P2(2)]);
end