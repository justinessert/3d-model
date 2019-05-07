function density = calcDensity(points)

if size(points,1)<=10
    density = 0;
else
    mu = mean(points);
    points_norm = points-mu;
    density_nm = sum(points_norm.^2);
    density_n = density_nm./size(points,1);
    density = sum(density_n./size(points,2));
end
end

