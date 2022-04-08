function res = residual_lgths(A, t, pts, pts_tilde)
    pts_exact = A * pts + t;
    res = sum((pts_exact - pts_tilde).^2, 1);
    res = nnz(res > 1e-27);
end