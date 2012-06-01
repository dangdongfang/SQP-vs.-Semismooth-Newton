function [x_ssn,it_ssn,t_ssn,x_sqp,it_sqp,t_sqp] = test_problem_A_huang_aggerwal_hs49(show)
    u = [];
    v = [];
    x0 = [10; 7; 2; -3; 0.8];
    tol = 0.00001;
    itmax = 100;
    A = [1 1 1 4 0; 0 0 1 0 5];
    b = [7; 6];
    G = [];
    r = [];
    G = [ G; -eye(length(u)); eye(length(v)) ];
    r = [ r; -u; v ];
    tic;
    %[x_ssn,fval_ssn,it_ssn] = active_set_strategy('func_for_problem_A_huang_aggerwal_hs49','grad_func_for_problem_A_huang_aggerwal_hs49','hess_func_for_problem_A_huang_aggerwal_hs49',A,b,G,r,x0,itmax,tol);
    [x_ssn,fval_ssn,it_ssn] = semismooth_newton('func_for_problem_A_huang_aggerwal_hs49','grad_func_for_problem_A_huang_aggerwal_hs49','hess_func_for_problem_A_huang_aggerwal_hs49',A,b,G,r,x0,itmax,tol);
    t_ssn = toc;
    x1 = sprintf('%.3f ',x_ssn);
    f1 = sprintf('f(x_ssn) = %.3f',fval_ssn);
    t1 = sprintf('solved in %.2f ms.',t_ssn*1000);
    str1 = ['x_ssn = [ ', x1, '], ', f1, ', it = ', num2str(it_ssn), ', ', t1];
    tic;
    [x_sqp,fval_sqp,it_sqp] = seq_quad_prog('func_for_problem_A_huang_aggerwal_hs49','grad_func_for_problem_A_huang_aggerwal_hs49','hess_func_for_problem_A_huang_aggerwal_hs49',A,b,G,r,x0,itmax,tol);
    t_sqp = toc;
    x2 = sprintf('%.3f ',x_sqp);
    f2 = sprintf('f(x_sqp) = %.3f',fval_sqp);
    t2 = sprintf('solved in %.2f ms.',t_sqp*1000);
    str2 = ['x_sqp = [ ', x2, '], ', f2, ', it = ', num2str(it_sqp), ', ', t2];
    if ( nargin == 0 )
        show = 1;
    end
    if ( show == 1 )
        u = sprintf('%.3f ',u);
        v = sprintf('%.3f ',v);
        x0 = sprintf('%.3f ',x0);
        str0 = ['u = [ ', u, '], v = [ ', v, '], x0 = [ ', x0, ']'];
        disp(str0);
        disp(str1);
        disp(str2);
    end
end