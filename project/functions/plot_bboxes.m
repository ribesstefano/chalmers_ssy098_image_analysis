function plot_bboxes(img, boxes, labels, scores)
    if true || nargin < 4
        figure, imshow(img);
        hold on;
        for n = 1:size(boxes, 1)
            % NOTE: We are supplying the labels AS THEY ARE, so need to
            % apply -1 to them.
            viz_label = "#" + string(num2str(labels(n))); % + " " + string(num2str(scores(n))); % + " (" + string(num2str(boxes(n, 1))) + "," + string(num2str(boxes(n, 2))) + ")";
            showShape('rectangle', round(boxes(n, :)), 'Label', viz_label, 'Color', 'cyan');
        end
        hold off;
    else
        annotations = string(labels) + ": " + string(scores);
        I = insertObjectAnnotation(img, 'rectangle', round(boxes), cellstr(annotations));
        imshow(I)
    end
end