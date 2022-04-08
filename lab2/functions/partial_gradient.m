function [wgrad, w0grad] = partial_gradient(w, w0, example_train, label_train)
    p = forward(w, w0, example_train);
    if ndims(example_train) == 3 && ndims(label_train) == 3
        % Batched case (ungraded for the assignment).
        % Get partial loss of positive and negative examples.
        pos_p = p(:, :, label_train == 1);
        neg_p = p(:, :, label_train == 0);
        % Get the positive and negative examples.
        pos_examples = example_train(:, :, label_train == 1);
        neg_examples = example_train(:, :, label_train == 0);
        % Compute the gradients following the equations and sum them over
        % the batch dimension (the 3rd one).
        wgrad_pos = sum((pos_p - 1) .* pos_examples, 3);
        wgrad_neg = sum(neg_p .* neg_examples, 3);
        wgrad = wgrad_pos + wgrad_neg;
        % The partial derivative of the loss and sigmoid w.r.t. bias term
        % is 1, so compute it and reduce the sum.
        w0grad = sum(pos_p - 1, 'all') + sum(neg_p, 'all');
    else
        % Single element case.
        if label_train == 1
            % Positive example
            wgrad = (p - 1) * example_train;
            w0grad = p - 1; %mean(p - 1, 'all');
        else
            % Negative example
            wgrad = p * example_train;
            w0grad = p; %mean(p, 'all');
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

function L = loss(p)
    L = sum(-log(p), 'all') + sum(-log(1 - p), 'all');
end