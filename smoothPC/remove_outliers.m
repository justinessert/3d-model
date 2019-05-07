function hyperplanes = remove_outliers(hyperplanes, outlier_percent_threshold)

for i = 1:size(hyperplanes,1)
    if ~strcmp(hyperplanes(i).type,'plane')
        continue
    end
    num_points = size(hyperplanes(i).points,1);
    points = [hyperplanes(i).points ones(num_points,1)];
    for j = 1:size(hyperplanes,1)
        if i==j
            continue
        end
        if ~strcmp(hyperplanes(j).type,'plane')
            continue
        end
        intersect_params = hyperplanes(j).params;
        intersect_vals = points*intersect_params';
        if length(find(intersect_vals<0))<outlier_percent_threshold*num_points
            ptsSmall = points(find(intersect_vals<0),1:3);
            ptsLarge = points(find(intersect_vals>=0),1:3);
            nSmall = length(ptsSmall);
            dSmall = calcDensity(ptsSmall);
            dLarge = calcDensity(ptsLarge);
            dKeep = (dLarge*.15>dSmall)&&(nSmall>250);
            if ~dKeep
                points = points(find(intersect_vals>=0),:);
            end
        elseif length(find(intersect_vals>0))<outlier_percent_threshold*num_points
            ptsSmall = points(find(intersect_vals>0),1:3);
            ptsLarge = points(find(intersect_vals<=0),1:3);
            nSmall = length(ptsSmall);
            dSmall = calcDensity(ptsSmall);
            dLarge = calcDensity(ptsLarge);
            dKeep = (dLarge*.15>dSmall)&&(nSmall>250);
            if ~dKeep
                points = points(find(intersect_vals<=0),:);
            end
        end
        hyperplanes(i).points = points(:,1:3);
    end
end

end

