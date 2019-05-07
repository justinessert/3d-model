function [plane, pc_outlier,mean_error] = fit_cylinder(pc,max_fit_length)

if max_fit_length>0
    % Fit a cylinder
    [model,inliers,outliers,mean_error] = pcfitcylinder(pc,max_fit_length);
    cylinder = select(pc, inliers);
    pc_outlier = select(pc, outliers);
    % Get the centers of the top and bottom of the cylinder
    center1 = [model.Parameters(1),model.Parameters(2),model.Parameters(3)];
    center2 = [model.Parameters(4),model.Parameters(5),model.Parameters(6)];

    % Normalize points so that center1 is at origin
    cyl_pts = cylinder.Location-center1;
    center2_norm = center2-center1;

    % Rotate matrix to align cylinder with z-axis
    R = get_rot_mat(center2_norm);
    rot_loc = cyl_pts*R;
    
    % Convert to polar coordinates
    [theta,rho,z] = cart2pol(rot_loc(:,1),rot_loc(:,2),rot_loc(:,3));
    % Replace rho with the model's radius
    rho_fit = repmat(model.Radius,size(rho,1),1);
    % Convert back to cartesian
    [x,y,z] = pol2cart(theta,rho_fit,z);
    % Reverse the rotation and add back the center1 point
    fit_loc = [x,y,z]/R+center1;

    plane = struct('params',model.Parameters,'points',fit_loc,'n_points',size(fit_loc,1),'type','cylinder');
else
    plane.n_points=-1;
    pc_outlier = pc;
    mean_error=Inf;
end

end

