function g = grad_himmelblau_func_1_v0(x)
	lambda = 0.000000001;
	g = grad_himmelblau_func_1(x) + lambda*x;
end