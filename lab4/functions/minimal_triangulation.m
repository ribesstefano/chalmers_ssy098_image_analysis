function U = minimal_triangulation(Ps, us)
    % NOTE: P is actually the projection matrix, i.e. P = K[R|t] = K[R|-RC]
    xl = us(1, 1);
    yl = us(2, 1);
    xr = us(1, 2);
    yr = us(2, 2);
    Pl = Ps{1};
    Pr = Ps{2};
    % The equations: us{1} = Ps{1} * X and us{2} = Ps{2} * X, can be
    % combined into the matrix A.
    A = [xl * Pl(3,:) - Pl(1,:);
         yl * Pl(3,:) - Pl(2,:);
         xr * Pr(3,:) - Pr(1,:);
         yr * Pr(3,:) - Pr(2,:)];
    % We now need to solve the homogeneous equation: Ax = 0, so x can be
    % found as the last column of the V component of the SVD of A.
    [U, S, V] = svd(A);
    % Finally, the last component needs to become 1, so we normalize.
    U = V(1:3, end) / V(end, end);
end