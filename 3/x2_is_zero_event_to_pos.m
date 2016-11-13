function [value, isterminal, direction] = x2_is_zero_event_to_pos(t, x)
	direction = 0;
	value = double(x(2) < 0);
	isterminal = ~value;
end
