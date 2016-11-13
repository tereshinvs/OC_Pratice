function reachsetdyn(alpha, t1, t2, N, varargin)
%	Xplus = fsolve(@(x) alpha - x - x * sin(x^3), 0);
%	Xminus = fsolve(@(x) -alpha - x - x * sin(x^3), 0);
	plus = @(x) alpha - x - x .* sin(x.^3);
	minus = @(x) -alpha - x - x .* sin(x.^3);
	x = -1 : 1e-5 : 1;
	yplus = plus(x);
	yminus = minus(x);
	
	EPS = 1e-4;
	tmp = find(abs(yplus) < EPS);
	Xplus = x(tmp);
	tmp = find(abs(yminus) < EPS);
	Xminus = x(tmp);
	
	[X, Y, X_switch, Y_switch] = reachset(alpha, t2);
	xmin_ = min(X);
	xmax_ = max(X);
	ymin_ = min(Y);
	ymax_ = max(Y);
	
	xmin = xmin_ - (xmax_ - xmin_) * 0.1;
	xmax = xmax_ + (xmax_ - xmin_) * 0.1;
	ymin = ymin_ - (ymax_ - ymin_) * 0.1;
	ymax = ymax_ + (ymax_ - ymin_) * 0.1;

	t = t1 : (t2 - t1) / N : t2;
	for i = 1 : size(t, 2)
		i
		size(t, 2)
		[X, Y, X_switch, Y_switch] = reachset(alpha, t(i));
		cla;
		hold on;
		plot(X, Y, 'Color', 'g');
		plot(X_switch, Y_switch);
		axis([xmin xmax ymin ymax]);
		title(num2str(t(i)));
		xlabel('x_1');
		ylabel('x_2');
		M(i) = getframe();
	end
	if nargin == 5
		movie2avi(M, varargin{1});
	else
		movie(M);
	end
end 