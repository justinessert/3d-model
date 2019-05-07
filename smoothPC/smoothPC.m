function [pc,pc_fit,hyperplanes] = smoothPC(pc_file, fit_params)
% max_fit_length, max_percent_outliers, trim_threshold, trim
% Load Point Cloud
pc = pcread(pc_file);

% Fit Planes To Point Cloud
hyperplanes = fit_pc(pc, fit_params);

num_planes = 0;
num_spheres = 0;
num_cylinders = 0;
for i = 1:size(hyperplanes,1)
    if strcmp(hyperplanes(i).type,'plane')
    	num_planes = num_planes+1;
    end
    if strcmp(hyperplanes(i).type,'sphere')
    	num_spheres = num_spheres+1;
    end
    if strcmp(hyperplanes(i).type,'cylinder')
    	num_cylinders = num_cylinders+1;
    end
end
disp(['Fit ' num2str(num_planes) ' planes, ' num2str(num_spheres) ' spheres, and ' num2str(num_cylinders) ' cylinders'])

if fit_params.trim_percent>0
    % Remove outlier points outside of shape
    hyperplanes = remove_outliers(hyperplanes, fit_params.trim_percent);
end

% Generate Cleaned Point Cloud
pc_fit = build_color_pc(hyperplanes);

% Plot Point Clouds
plot_pcs(pc,pc_fit)

end