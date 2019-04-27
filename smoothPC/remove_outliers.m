function planes = remove_outliers(planes, outlier_percent_threshold)

for i = 1:size(planes,1)
    num_points = size(planes(i).points,1);
    points = [planes(i).points ones(num_points,1)];
    for j = 1:size(planes,1)
        if i==j
            continue
        end
        intersect_params = planes(j).params;
        intersect_vals = points*intersect_params';
        if length(find(intersect_vals<0))<outlier_percent_threshold*num_points
            points = points(find(intersect_vals>=0),:);
        elseif length(find(intersect_vals>0))<outlier_percent_threshold*num_points
            points = points(find(intersect_vals<=0),:);
        end
        planes(i).points = points(:,1:3);
    end
end

end

