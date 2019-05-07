pc_file = 'rubiksPC/cleanedPCs/rubiksCubeStringCleaned.ply';

% Once there are fewer than outliers_percent% of points left from the original
% point cloud, stop trying to fit points to planes, spheres, and cylinders
fit_params.outlier_percent = .05;

% If any of max_fit_[plane,sphere,cylinder] or trim_percent are 0, those 
% respective sections will be skipped

% Maximum distance from a plane to consider those points part of a plane
fit_params.max_fit_plane = .12;

% Maximum distance from a sphere to consider those points part of a sphere
fit_params.max_fit_sphere = 0;

% Maximum distance from a cylinder to consider those points part of a cylinder
fit_params.max_fit_cylinder = 0;

% If fewer than trim_percent of points on a plane are on one side of the
% intersection of that plane with another, those points will be trimmed
fit_params.trim_percent = .1;

[pc,pc_fit,planes] = smoothPC(pc_file, fit_params);

smooth_dir = 'rubiksPC/finalSmoothPCs/';
pcwrite(pc_fit,[smooth_dir,'misc.ply']);



% puzzle params:
% fit_params.max_fit_plane = .075;
% fit_params.max_fit_sphere = .075;
% fit_params.max_fit_cylinder = 0;
% fit_params.trim_percent = .05;

% pillbottle params:
% fit_params.max_fit_plane = .05;
% fit_params.max_fit_sphere = 0;
% fit_params.max_fit_cylinder = .025;
% fit_params.trim_percent = .1;

% angledCube params:
% fit_params.max_fit_plane = .12;
% fit_params.max_fit_sphere = 0;
% fit_params.max_fit_cylinder = 0;
% fit_params.trim_percent = .1;

% stringCube params:
% fit_params.max_fit_plane = .12;
% fit_params.max_fit_sphere = 0;
% fit_params.max_fit_cylinder = 0;
% fit_params.trim_percent = .1;
