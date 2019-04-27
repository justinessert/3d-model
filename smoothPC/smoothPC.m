function [pc,pc_fit] = smoothPC(pc_file, max_fit_length, max_percent_outliers, trim_threshold)
% Load Point Cloud
pc = pcread(pc_file);

% Fit Planes To Point Cloud
planes = fit_pc(pc, max_fit_length, max_percent_outliers);

% Remove outlier points outside of shape
planes = remove_outliers(planes, trim_threshold);

% Generate Cleaned Point Cloud
pc_fit = build_color_pc(planes);

% Plot Point Clouds
plot_pcs(pc,pc_fit)

end