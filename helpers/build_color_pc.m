function pc = build_color_pc(planes)

all_points = [];
all_colors = [];
for i=1:size(planes,1)
    all_points = [all_points; planes(i).points];
    
    color = de2bi(mod(i,8),3);
    color_arr = repmat(color,size(planes(i).points,1),1);
    all_colors = [all_colors; color_arr];
end

pc = pointCloud(all_points, 'Color', all_colors);

end

