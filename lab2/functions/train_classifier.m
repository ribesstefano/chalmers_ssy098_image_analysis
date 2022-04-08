function net = train_classifier(layers, imgs_train, labels_train, imgs_val, labels_val)
    num_epochs = 20;
    disp(['INFO. Training network for ' num2str(num_epochs) ' epochs.'])
    options = trainingOptions('sgdm', 'MaxEpochs', num_epochs, 'Verbose', 0);
    net = trainNetwork(imgs_train, labels_train, layers, options);
    acc_count = nnz(net.classify(imgs_val) == labels_val); 
    acc = acc_count / length(labels_val);
    disp(['INFO. Network accuracy: ' num2str(acc * 100) '%%'])
end