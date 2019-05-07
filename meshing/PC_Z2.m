
clear; clc; 

nPointsX = 50;
nPointsY = 50;
zWidth = 10;
height = 42;

Points = Z_pc(nPointsX,nPointsY,zWidth,height);
Points = Points+(rand(size(Points))*2-1)*nPointsX/100;
figure(1); plot3(Points(:,1),Points(:,2),Points(:,3),'.'); axis equal; grid on; view(2);
axis off
zPC = pointCloud(Points); figure(3); pcshow(zPC);
fv = isosurface(Points(:,1),Points(:,2),Points(:,3),V,isovalue)
%shp = alphaShape(Points); 
%figure(2); plot(shp); axis equal; axis off; view(2); 

%%

k = shp.boundaryFacets();
AR = zeros(length(k(:,1)),1);
for ii=1:length(k(:,1))
a = norm(Points(k(ii,1),:)-Points(k(ii,2),:));
b = norm(Points(k(ii,2),:)-Points(k(ii,3),:));
c = norm(Points(k(ii,1),:)-Points(k(ii,3),:));
AR(ii) = a*b*c/(b+c-a)/(a+c-b)/(a+b-c);
end
inds = find(AR>1.22);

figure(1); trimesh(k(inds,:),Points(:,1),Points(:,2),Points(:,3)); 
% figure(2); plot(AR,'.');

kk = k(inds,:);
kk = [setdiff(1:length(Points(:,1)),k(:))' ; kk(:)];

figure(1); plot3(Points(kk,1),Points(kk,2),Points(kk,3),'.'); axis equal; grid on; view(2);
shp2 = alphaShape(Points(kk,:),inf); plot(shp2); axis equal; axis off; 



[kkk,ptkkk] = shp2.boundaryFacets();
AR2 = zeros(length(kkk(:,1)),1);
for ii=1:length(kkk(:,1))
a = norm(ptkkk(kkk(ii,1),:)-ptkkk(kkk(ii,2),:));
b = norm(ptkkk(kkk(ii,2),:)-ptkkk(kkk(ii,3),:));
c = norm(ptkkk(kkk(ii,1),:)-ptkkk(kkk(ii,3),:));
AR2(ii) = a*b*c/(b+c-a)/(a+c-b)/(a+b-c);
end
inds2 = find(AR2>1.2073);


figure(1); trimesh(kkk(inds2,:),ptkkk(:,1),ptkkk(:,2),ptkkk(:,3)); 
% figure(2); plot(AR2,'.');

kkkk = kkk(inds2,:);
kkkk = [setdiff(1:length(ptkkk(:,1)),kkk(:))' ; kkkk(:)];

figure(1); plot3(ptkkk(kkkk,1),ptkkk(kkkk,2),ptkkk(kkkk,3),'.'); axis equal; grid on; view(2);
shp2 = alphaShape(ptkkk(kkkk,:),inf); plot(shp2); axis equal; axis off; 



