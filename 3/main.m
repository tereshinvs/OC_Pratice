clear;
format long;

[X, Y, X_switch, Y_switch] = reachset(2.0, 2.0);
%X
%Y
plot(X, Y, 'g', X_switch, Y_switch);
axis([-2.5 2.5 -2.5 2.5])
xlabel('x_1')
ylabel('x_2')
title('t = 2.0');
%reachsetdyn(2.0, 0.1, 5.0, 50, 'film.avi');

%hold on;
%plot(X, Y, 'LineStyle', 'none', 'MarkerEdgeColor', 'g');
%plot(X, Y, '.g')
%plot(X_switch, Y_switch);
