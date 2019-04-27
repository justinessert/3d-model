pc_file = 'rubiksPC/cleanedPCs/rubiksCubeAngleCleaned.ply';

[pc,pc_fit] = smoothPC(pc_file, .12, .05, .1);
% [pc,pc_fit] = smoothPC_2stage(pc_file, .05, .075, .025, .1)

smooth_dir = 'rubixPC/smoothed_pc';
pcwrite(pc_fit,[smooth_dir,'pc_angle_fit_12_edge.ply']);