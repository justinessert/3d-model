function plot_pcs(pc1, pc2)

figure;
ax1 = subplot(1,2,1);
pcshow(pc1)
ax2 = subplot(1,2,2);
pcshow(pc2)

Link = linkprop([ax1, ax2],{'CameraUpVector', 'CameraPosition', 'CameraTarget'});
setappdata(gcf, 'StoreTheLink', Link);
end

