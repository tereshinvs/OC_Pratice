function dy = control_system(t, y)
	u1 = get_u1(y(3), y(4), y(5));
	u2 = get_u2(y(3), y(4), y(5), y(1), y(2));
	dy = zeros(5, 1);
	dy(1) = y(2) + u2 + 2 * u1;
	dy(2) = u1 + u2 * y(2);
	dy(3) = 0;
	dy(4) = 0;
	dy(5) = -y(4) - u2 * y(5);
end
