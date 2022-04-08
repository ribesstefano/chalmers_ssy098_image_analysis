function [A, t] = estimate_affine(pts, pts_tilde)
    % NOTE: If we have: A = [[a, b], [c, d]], then an affine transformation
    % can be defined as follows:
    %
    % [x, y] * A + [tx, ty] = [a * x + c * y + tx, b * x + d * y + ty]
    %
    % In order to estimate the parameters, we rewrite the transformation as
    % a system of linear equations, as follows:
    %
    % C = [a, c, b, d, tx, ty].T
    % 
    % [[x, y, 0, 0, 1, 0],
    %  [0, 0, x, y, 0, 1]] * C = [a * x + c * y + tx, b * x + d * y + ty]
    %
    % Stack starting points
    T = zeros(length(pts) * 2, 6);
    for n = 0:length(pts) - 1
        x = pts(1, n + 1);
        y = pts(2, n + 1);
        T(n * 2 + 1, :) = [x; y; 0; 0; 1; 0];
        T(n * 2 + 2, :) = [0; 0; x; y; 0; 1];
    end
    % Stack transformed points
    % TODO: Most likely there exists a matlab function to this w/o a loop
    b = zeros(1, prod(size(pts_tilde)));
    for n = 0:length(pts_tilde) - 1
        b(n * 2 + 1) = pts_tilde(1, n + 1);
        b(n * 2 + 2) = pts_tilde(2, n + 1);
    end
    % Estimate parameters (NOTE: The number of rows must match)
    x = T \ b';
    a = x(1);
    c = x(2);
    b = x(3);
    d = x(4);
    tx = x(5);
    ty = x(6);
    A = [[a; b], [c; d]];
    t = [tx; ty];
end