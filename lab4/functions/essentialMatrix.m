function E = essentialMatrix(P1, P2)
    % We know that:
    % * E = K1.T * F * K2
    % * det(E) = 0
    % * rank(E) = 2
    % * E = U diag([1 1 0]) V.T, i.e. applying SVD
    % but the above are just properties...
    % We also know that: P = K[R|t], and: K^-1 * P = [R|t] is the
    % calibrated camera matrix.
    % If we have a pair of normalized camera matrices P = [I|0] and
    % P' = [R|t], then: E = [t]x R, where [t]x is the matrix representation
    % of the cross product with t (i.e. an outer product).
    % The inner matrix K should be triangular.
    % The nullspace of the camera matrix P gives you the camera center C.
    
    [U, S, C1] = svd(P1);
    C1 = C1(1:3) / C1(3, 3);
    [U, S, C2] = svd(P2);
    C2 = (C2(1:3) / C2(3, 3))';

    % I know that if the two cameras are normalized, then they can
    % be written as: P1 = [I|0] and P2 = [R|t],
    % Then the essential matrix would simply be: E = [t]x R, where [t]x is
    % the matrix representation of the cross product with t.
    % In particular: [t]x = [0 -t3 t2; t3 0 -t1; -t2 t1 0];
    Rt = [1 0 0 0; 0 1 0 0; 0 0 1 0];
    [Rt1, K1] = qr(P1(:, 1:3))
    [Rt2, K2] = qr(P2(:, 1:3));
    K1 = K1 ./ K1(3, 3)
    K2 = K2 ./ K2(3, 3)
    P1_norm = inv(K1) * P1
    P2_norm = inv(K2) * P2
    E = zeros(3, 3);
end