function y = consistency(q_c,e_c,alpha,beta)
	if q_c == 1
		y = CLAMP(((e_c-alpha) / (beta-alpha)), -1, 1);
	elseif q_c == 0
		y = CLAMP(1 -(abs(e_c) - alpha) / (beta-alpha), -1, 1);
	else
		y = CLAMP((-e_c-alpha) / (beta-alpha), -1, 1);
	end
end