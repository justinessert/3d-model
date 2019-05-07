%% Reduced Order Point Clouds (ROPCs)
%% Reset matlab
clear; clc; clf; close all;

%% Load Data
% x = gallery('uniformdata',10000,1,1);
% y = gallery('uniformdata',10000,1,10);
% z = gallery('uniformdata',10000,1,5);
% PC = pointCloud([x,y,z]);
tic
name = 'puzzle_pc_cleaned.ply';
PC = pcread(name);
% Cluster Pointsclc
oldPC = PC;
pointsList = [1:size(oldPC.Location,1)]';
points(:,1) = pointsList;
points(:,[2:4]) = oldPC.Location;
radius = 0.2;

currInd = 1;
while (~isempty(pointsList))
    currPoint = pointsList(1);
    currPointCoords = points(1,[2:4]);
    [NN_list,dists] = findNeighborsInRadius(PC,currPointCoords,radius);
    centroidX = mean(points(NN_list,2));
    centroidY = mean(points(NN_list,3));
    centroidZ = mean(points(NN_list,4));
    newPts(currInd,:) = [currInd,centroidX,centroidY,centroidZ];
    currInd = currInd + 1;
    pointsList(NN_list) = [];
    points(NN_list,:) = [];
    PC = pointCloud(points(:,[2:4]));
    pointsRemoved = length(NN_list);
    pointsLeft = size(PC.Location(:,1),1);
    if(mod(currInd,15) == 0)
        clc;
    else
        disp(['Points Remaining: ',num2str(pointsLeft)]);
    end
    
end
newPC = pointCloud(newPts(:,[2:4]));
redPts = oldPC.Count - newPC.Count
disp(['The model has been reduced by: ',...
    num2str(abs(pct_err(size(oldPC.Location(:,1),1),size(newPC.Location(:,1),1)))),'%']);

% figure(2); plot3(oldPC.Location(:,1),oldPC.Location(:,2),oldPC.Location(:,3),'r.');
% hold on
% plot3(newPC.Location(:,1),newPC.Location(:,2),newPC.Location(:,3),'b.','Markersize',20);
% hold off
% figure(3)
% plot3(newPC.Location(:,1),newPC.Location(:,2),newPC.Location(:,3),'b.','Markersize',20)
figure(100);
hold on;
ax1 = subplot(1,2,2);plot3(oldPC.Location(:,1),oldPC.Location(:,2),oldPC.Location(:,3),'r.');
axis equal; axis off; 
ax2 = subplot(1,2,1);plot3(newPC.Location(:,1),newPC.Location(:,2),newPC.Location(:,3),'b.','Markersize',20);
axis equal; axis off; 
linkprop([ax1 ax2],{'CameraPosition','CameraUpVector'});
hold off;
fileName = strcat('Red_',num2str(radius),'_',name,'.mat');
save(fileName,'newPC','radius','oldPC')
toc
shp = alphaShape(newPC.Location);
figure(101); plot(shp); axis equal; axis off;
