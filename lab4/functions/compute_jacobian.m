function jacobian = compute_jacobian(Ps, U)
    jacobian = zeros(2 * length(Ps), 3);
    Us = [U; 1];
    for n = 1:length(Ps)
        P = Ps{n};
        a = P(1, :);
        b = P(2, :);
        c = P(3, :);
        cUs = c * Us; % NOTE: It's a scalar value.
        % NOTE: Consider only the first three elements: each row vector,
        % i.e. a b and c, is differentiated by each element of U.
        % TODO: It should be 2N x 3, but at first it looks to be 2N x 4...
        x = (a(1:3) * cUs - (a * Us) * c(1:3)) / (cUs.^2);
        y = (b(1:3) * cUs - (b * Us) * c(1:3)) / (cUs.^2);
        jacobian((n - 1) * 2 + 1, :) = x;
        jacobian((n - 1) * 2 + 2, :) = y;
    end
end

