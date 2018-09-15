function [] = plot_positions(pos, fig_idx,box_dim, d,updated_idx)
%BOILERPLATE TO DRAW PARTICLES CORRECT SIZE
%Obtain the axes size (in axpos) in Points
%Stolen from https://www.mathworks.com/matlabcentral/answers/101738-how-do-i-specify-the-size-of-the-markers-created-by-the-scatter-plot-in-units-proportional-to-the-da

figure(fig_idx)
s=d; %particle size
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);
markerWidth = s/diff(xlim)*axpos(3); % Calculate Marker width in points

h=scatter(pos(1,:), pos(2,:)); xlim([0,box_dim]); ylim([0,box_dim]); hold on 
set(h, 'SizeData', markerWidth^2)

if ~isempty(updated_idx)
    g=scatter(pos(1,updated_idx), pos(2,updated_idx), 'MarkerFaceColor', 'g');
    set(g, 'SizeData', markerWidth^2)
end

xlabel('X1'); ylabel('X2')
hold off
    
%%

%plot([0,0], [0,box_dim], 'Color', 'b', 'LineWidth', 2); hold on
%plot([0,0], [box_dim, box_dim], 'Color', 'b'); hold on
%plot([box_dim ,0], [box_dim, box_dim]); hold on
%plot([0, box_dim], [box_dim, box_dim]); hold on

end