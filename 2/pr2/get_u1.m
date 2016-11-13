function u1 = get_u1(psi0, psi1, psi2)
	global gamma;

	if (gamma * psi0 - 2 * psi1 - psi2) / (2 * psi0) <= 0
		u1(1) = (gamma * psi0 - 2 * psi1 - psi2) / (2 * psi0);
	else
		if (-gamma * psi0 - 2 * psi1 - psi2) / (2 * psi0) >= 0
			u1(1) = (-gamma * psi0 - 2 * psi1 - psi2) / (2 * psi0);
		else
			u1(1) = 0;
		end
	end
end