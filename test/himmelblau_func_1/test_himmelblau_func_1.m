function [x_ssn,it_ssn,t_ssn,x_sqp,it_sqp,t_sqp] = test_himmelblau_func_1(show)
    lambda = 0.01;
    a = [5; 5];
    b = [20; 20];
    x0 = [15; 15];
    m0 = zeros(2,1);
    tol = 0.0001;
    itmax = 100;
    tic;
    [x_ssn,fval_ssn,it_ssn] = active_set_strategy('himmelblau_func_1','grad_himmelblau_func_1','hess_himmelblau_func_1',lambda,a,b,x0,m0,itmax,tol);
    %[x_ssn,fval_ssn,it_ssn] = semismooth_newton('himmelblau_func_1','grad_himmelblau_func_1','hess_himmelblau_func_1',lambda,a,b,x0,itmax,tol);
    t_ssn = toc;
    x1 = sprintf('%.3f ',x_ssn);
    f1 = sprintf('f(x_ssn) = %.3f',fval_ssn);
    t1 = sprintf('solved in %.2f ms.',t_ssn*1000);
    str1 = ['x_ssn = [ ', x1, '], ', f1, ', it = ', num2str(it_ssn), ', ', t1];
    A = [ -eye(length(a)); eye(length(b)) ];
    c = [ -a; b ];
    tic;
    [x_sqp,fval_sqp,it_sqp] = seq_quad_prog('himmelblau_func_1_v0','grad_himmelblau_func_1_v0','hess_himmelblau_func_1_v0',A,c,x0,itmax,tol);
    t_sqp = toc;
    x2 = sprintf('%.3f ',x_sqp);
    f2 = sprintf('f(x_sqp) = %.3f',fval_sqp);
    t2 = sprintf('solved in %.2f ms.',t_sqp*1000);
    str2 = ['x_sqp = [ ', x2, '], ', f2, ', it = ', num2str(it_sqp), ', ', t2];
    if ( nargin == 0 )
        show = 1;
    end
    if ( show == 1 )
        a = sprintf('%.3f ',a);
        b = sprintf('%.3f ',b);
        x0 = sprintf('%.3f ',x0);
        str0 = ['a = [ ', a, '], b = [ ', b, '], x0 = [ ', x0, ']'];
        disp(str0);
        disp(str1);
        disp(str2);
    end
end
