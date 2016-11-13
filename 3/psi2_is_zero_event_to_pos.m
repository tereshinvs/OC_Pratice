function [value, isterminal, direction] = psi2_is_zero_event_to_pos(t, x)
	direction = 0;
	value = double(x(4) < 0);
	isterminal = ~value;
end
