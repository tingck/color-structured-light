function s = score(q,e,alpha,beta)
	con_r = consistency(q(1),e(1),alpha,beta);
	con_g = consistency(q(2),e(2),alpha,beta);
	con_b = consistency(q(3),e(3),alpha,beta);
	s = min([con_r,con_g,con_b]);
end