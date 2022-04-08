function errors = reprojection_errors(Ps, us, U)
    us_hat = zeros(2, size(Ps, 1));
    for n = 1:size(Ps, 2)
        u = Ps{n} * [U; 1];
        if u(3) < 0
            us_hat(:, n) = inf;
        else
            us_hat(:, n) = u(1:2) / u(3);
        end
    end
    errors = sqrt(sum((us - us_hat) .^ 2));
end