
function [] = make_vel_dist_plots(vel, fig_idx)

vel_edges=-2:0.05:2;
g=arrayfun(@(c) 1/sqrt(pi)*exp(-c^2), vel_edges);

figure(fig_idx)
subplot(1,2,1)
histogram(vel(1,:),vel_edges,'Normalization','pdf'); hold on
plot(vel_edges, g, 'r', 'LineWidth', 2); hold off


title('X Vel dist')
subplot(1,2,2)
histogram(vel(2,:),vel_edges,'Normalization','pdf');hold on
title('Y Vel dist')
plot(vel_edges, g, 'r', 'LineWidth', 2); hold off

end