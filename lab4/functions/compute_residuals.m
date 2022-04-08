function all_residuals = compute_residuals(Ps, us, U)
    all_residuals = zeros(2 * length(Ps), 1);
    Us = [U; 1];
    for n = 1:length(Ps)
        P = Ps{n};
        a = P(1, :);
        b = P(2, :);
        c = P(3, :);
        % NOTE: There might be additional and more precise checks to do...
        if c * Us > 0
            x = (a * Us) / (c * Us) - us(1, n);
            y = (b * Us) / (c * Us) - us(2, n);
            all_residuals((n - 1) * 2 + 1, :) = x;
            all_residuals((n - 1) * 2 + 2, :) = y;
        else
            all_residuals((n - 1) * 2 + 1, :) = inf;
            all_residuals((n - 1) * 2 + 2, :) = inf;
        end
    end
end

