function [plane, pc_outlier,mean_error] = fit_sphere(pc,max_fit_length)

if max_fit_length>0
    [model,inliers,outliers,mean_error] = pcfitsphere(pc,max_fit_length);

    sphere = select(pc, inliers);
    pc_outlier = select(pc, outliers);

    sph_pts_norm = sphere.Location-model.Center;
    sph_pts_fit_norm = model.Radius./sqrt(sum(sph_pts_norm.^2,2)).*sph_pts_norm;
    sph_pts_fit = sph_pts_fit_norm+model.Center;

    plane = struct('params',model.Parameters,'points',sph_pts_fit,'n_points',size(sph_pts_fit,1),'type','sphere');
else
    plane.n_points=-1;
    pc_outlier = pc;
    mean_error=Inf;
end

end

