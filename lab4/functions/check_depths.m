function positive = check_depths(Ps, U)
    positive = zeros(size(Ps, 1));
    for n = 1:length(Ps)
        x = Ps{n} * [U; 1];
        if x(3) < 0
            positive(n) = false;
        else
            positive(n) = true;
        end
    end
end