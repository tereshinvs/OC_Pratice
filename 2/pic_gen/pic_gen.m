x = 0.1 : 0.001 : 1

hold on
plot(x, -1 ./ x)
plot(x, -2 * ones(size(x)), 'm')

plot(x, -5 * x + 3, 'g')

legend('\psi_2 = \psi_1 / x_2', '\psi_2 = \gamma / 2 - 2 \psi_1', 'Possible trajectory')

xlabel('x_2')
ylabel('\psi_2')