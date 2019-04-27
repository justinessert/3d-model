function [plane, pc_outlier] = fit_plane(pc,max_fit_length)

[model,inliers,outliers] = pcfitplane(pc,max_fit_length);
plane = select(pc, inliers);
pc_outlier = select(pc, outliers);

params = model.Parameters;
normal = model.Normal;
x=plane.Location';
y = x-normal'*(normal*x+params(4));
plane = struct('params',params,'points',y');

end

