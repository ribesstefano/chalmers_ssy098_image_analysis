function layers = basic_cnn_classifier()
    layers = [
                imageInputLayer([28 28 1]);
                convolution2dLayer(5, 20);
                reluLayer();
                maxPooling2dLayer(2, 'Stride', 2);
                fullyConnectedLayer(10);
                softmaxLayer();
                classificationLayer()
            ];
end