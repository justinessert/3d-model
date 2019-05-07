%% Triangulate Points
%% Reset Matlab
clear; clc; close all;
%% Load Point cloud
pc = pcread('pc_fit_025_withBottom.ply');
pcPoints = double(pc.Location);         % all xyz coordinates of pts
numPts = pc.Count;                      % count of the pts
%% Algorithm
K = boundary(pcPoints,0.6);
trisurf(K,pcPoints(:,1),pcPoints(:,2),pcPoints(:,3),'FaceColor','cyan','FaceAlpha',0.3)


% %%
% randPts = randperm(numPts);             % randomly permute all points
% for i = 1:numPts
%    currPt = randPts(i); 
%    currCords = pcPoints(currPt,:);
%     
% end
%%
DT = delaunay(pcPoints(:,1),pcPoints(:,2),pcPoints(:,3));
%[C,v] = convexHull(DT);
trisurf(DT,pcPoints(:,1),pcPoints(:,2),pcPoints(:,3),'FaceColor','cyan','FaceAlpha',0.3)