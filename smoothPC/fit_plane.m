function [plane, pc_outlier,mean_error] = fit_plane(pc,max_fit_length)

if max_fit_length>0
    [model,inliers,outliers,mean_error] = pcfitplane(pc,max_fit_length);
    plane = select(pc, inliers);
    pc_outlier = select(pc, outliers);

    params = model.Parameters;
    normal = model.Normal;
    x=plane.Location';
    y = x-normal'*(normal*x+params(4));
    plane = struct('params',params,'points',y','n_points',size(y',1),'type','plane');
else
    plane.n_points=-1;
    pc_outlier = pc;
    mean_error=Inf;
end

end

