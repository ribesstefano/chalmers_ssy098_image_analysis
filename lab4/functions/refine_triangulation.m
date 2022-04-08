function U = refine_triangulation(Ps, us, Uhat, n_refinements)
    if nargin < 4
        n_refinements = 5;
    end
    U = Uhat;
    for n = 1:n_refinements
        r = compute_residuals(Ps, us, U);
        J = compute_jacobian(Ps, U);
        U = U - ((J' * J) \ J') * r;
    end
end

