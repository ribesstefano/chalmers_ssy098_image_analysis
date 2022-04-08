num_correct = 0;
for n = 1:length(digits_validation)
    label = classify_digit(digits_validation(n).image, digits_training);
    if label == digits_validation(n).label
        num_correct = num_correct + 1;
    end
end
disp(['INFO. Percentage correct: ' num2str(num_correct / length(digits_validation) * 100) '%'])