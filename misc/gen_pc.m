x = repmat([0:.05:9.95]',200,1);
y = reshape(repmat([0:.05:9.95]',1,200).',[],1);
z = repmat([0:0.05:0.20 flip(0.05:.05:0.25)],1,4000)';
points = [x y z];

pc = pointCloud(points);
pcwrite(pc, 'texture.ply');
