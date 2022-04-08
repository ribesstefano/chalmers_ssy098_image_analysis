function predicted_labels = classify(examples_val, w, w0)
    predicted_labels = zeros(1, size(examples_val, 2));
    for n = 1:size(examples_val, 2)
        p = forward(w, w0, cell2mat(examples_val(n)));
        if p > 0.5
            predicted_labels(n) = 1;
        else
            predicted_labels(n) = 0;
        end
    end
end

function p = forward(w, w0, I)
    if ndims(w) == 3
        % Batched execution
        y = pagemtimes(I, w) + w0;
    else
        y = dot(I, w) + w0;
    end
    p = exp(y) / (1 + exp(y));
end