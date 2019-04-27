% Fit Planes To Point Cloud
function planes = fit_pc(pc, max_fit_length, max_percent_outliers)

pc_pts = size(pc.Location,1);
orig_pc_pts=pc_pts;
pc_outlier = pc;

planes = [];
while pc_pts>max_percent_outliers*orig_pc_pts
    [plane, pc_outlier] = fit_plane(pc_outlier,max_fit_length);
    
    pc_pts = size(pc_outlier.Location,1);
    planes = [planes;plane];
end