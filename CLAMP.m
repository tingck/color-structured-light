function y = CLAMP(x,x0,x1)
	if x < x0
		y = x0;
	end
	if x0 < x && x <= x1
		y = x;
	end
	if x1 < x
		y = x1;
	end
end