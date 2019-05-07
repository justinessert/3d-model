%function linePoints = projOnIntersection(ptsPlane, intersectPlane, points)
% Projects a set of points on a plane onto the intersection of that plane
% with another plane

ptsPlane=planes(1);
intersectPlane=planes(3);

points = planes(1).points;

intersectPoints = getPtsOnIntersection(ptsPlane.points',intersectPlane.points');
A = intersectPoints(1,:);
B = intersectPoints(2,:);

AB = B-A;
AP = points-A;

linePoints = A+(AP*AB')./(AB*AB')*AB;

npp = size(ptsPlane.points,1);
nip = size(intersectPlane.points,1);
nlp = size(linePoints,1);

colors = [repmat([1 0 0],npp,1);repmat([0 1 0],nip,1);repmat([0 0 1],nlp,1)];
pts = [ptsPlane.points; intersectPlane.points; linePoints];
pc = pointCloud(pts, 'Color',colors);

figure;
pcshow(pc); hold on;
plot3(intersectPoints(1,2),intersectPoints(1,1),intersectPoints(1,3), 'ko');

%end

