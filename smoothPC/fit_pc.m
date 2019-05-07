% Fit Planes To Point Cloud
function hyperplanes = fit_pc(pc, fit_params)

% max_fit_length, max_percent_outliers
pc_pts = size(pc.Location,1);
orig_pc_pts=pc_pts;
pc_outlier = pc;

hyperplanes = [];

if fit_params.max_fit_plane+fit_params.max_fit_sphere+fit_params.max_fit_cylinder>0
    while pc_pts>fit_params.outlier_percent*orig_pc_pts
        % Fit points to a plane
        [plane, plane_pc_outlier,plane_mean_error] = fit_plane(pc_outlier,fit_params.max_fit_plane);
        hyperplane = plane;
        next_pc_outlier = plane_pc_outlier;
        mean_error=plane_mean_error;
        % Fit points to a cylinder
        [cylinder, cylinder_pc_outlier,cylinder_mean_error] = fit_cylinder(pc_outlier,fit_params.max_fit_cylinder);
        % If cylinder is the best fit, use the cylinder
        if cylinder_mean_error<mean_error
            hyperplane = cylinder;
            next_pc_outlier = cylinder_pc_outlier;
            mean_error = cylinder_mean_error;
        end
        
        % Fit points to a sphere
        [sphere, sphere_pc_outlier, sphere_mean_error] = fit_sphere(pc_outlier,fit_params.max_fit_sphere);
        % If sphere is the best fit, use the sphere
        if sphere_mean_error<mean_error
            hyperplane = sphere;
            next_pc_outlier = sphere_pc_outlier;
            mean_error = sphere_mean_error;
        end
        
        pc_outlier = next_pc_outlier;
        pc_pts = size(pc_outlier.Location,1);
        hyperplanes = [hyperplanes;hyperplane];
    end
else
    hyperplanes = [struct('params',nan,'points',pc.Location,'type','none')];
end
    
    