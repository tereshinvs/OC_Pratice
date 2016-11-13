function [X, Y] = remove_intersection(X_, Y_)
	N = size(X_, 1);
	leftdown = 1;
	for i = 1 : N
		if X_(i) < X_(leftdown) || X_(i) == X_(leftdown) && Y_(i) < Y_(leftdown)
			leftdown = i;
		end
	end
	
	X_ = circshift(X_, -leftdown + 1);
	Y_ = circshift(Y_, -leftdown + 1);
	X_ = [X_; X_(1)];
	Y_ = [Y_; Y_(1)];
	
	X = X_(1 : 3);
	Y = Y_(1 : 3);
	for i = 4 : (N - 1)
		intersects_with = -1;
		for j = 1 : size(X, 1) - 2
			if segments_intersect([X(j); Y(j)], [X(j + 1); Y(j + 1)], [X(end); Y(end)], [X_(i); Y_(i)])
				intersects_with = j;
				break;
			end
		end
		if intersects_with == -1
			X = [X; X_(i)];
			Y = [Y; Y_(i)];
		else
			X = [X(1 : intersects_with); X_(i)];
			Y = [Y(1 : intersects_with); Y_(i)];
		end
	end
	X = [X; X_(end - 1 : end)];
	Y = [Y; Y_(end - 1 : end)];
end