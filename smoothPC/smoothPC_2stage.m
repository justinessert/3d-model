function [pc,pc_fit] = smoothPC_2stage(pc_file, max_percent_outliers, max_fit_pc_length, max_fit_plane_length, trim_threshold)

% Load Point Cloud
pc = pcread(pc_file);

% Fit Planes To Point Cloud

pc_pts = size(pc.Location,1);
orig_pc_pts=pc_pts;
pc_outlier = pc;
planes = [];

while pc_pts>max_percent_outliers*orig_pc_pts
    [~,inliers,outliers] = pcfitplane(pc_outlier,max_fit_pc_length);
    plane = select(pc_outlier, inliers);
    pc_outlier = select(pc_outlier, outliers);
    
    pc_pts = numel(outliers);

    plane_planes = fit_pc(plane, max_fit_plane_length, max_percent_outliers);
    planes = [planes; plane_planes];
end

% Remove outlier points outside of shape

planes = remove_outliers(planes, trim_threshold);

% Generate Cleaned Point Cloud

pc_fit = build_color_pc(planes);

% Plot Point Clouds

plot_pcs(pc,pc_fit)

end
