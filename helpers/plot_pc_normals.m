function plot_pc_normals(pc)
figure;
pcshow(pc)
hold on;
normals = pcnormals(pc);
x = pc.Location(:,1);
y = pc.Location(:,2);
z = pc.Location(:,3);
u = normals(:,1);
v = normals(:,2);
w = normals(:,3);
quiver3(x,y,z,u,v,w);
hold off

end

