function [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train, sequential)
    if size(examples_train, 2) ~= size(labels_train, 2)
        error(['ERROR. Training and labels sets have different dimensions!'])
    end
    if nargin > 5 && sequential
        x = examples_train;
        y = labels_train;
    else
        % Shuffle the input training data to emulate random picking.
        rand_idx = randperm(size(examples_train, 2));
        x = examples_train(rand_idx);
        y = labels_train(rand_idx);
    end
    for n = 1:size(examples_train, 2)
        [wgrad, w0grad] = partial_gradient(w, w0, cell2mat(x(n)), y(n));
        w = w - lrate * wgrad;
        w0 = w0 - lrate * w0grad;
    end
end