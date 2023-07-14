function [] = plot_learning_curve(list_points, y_log, y_label)
% Plots multiple learning curves all on the same image
% Input:
%       list_points     list of structures containing the points to plot
%                       e.g. [pts1, ..., ptsN] where pts1.x are the values
%                       for the x-axis, pts1.y are the values for the
%                       y-axis and pts1.legend is the name to identify 
%                       the curve on the image
%       y_log           boolean to choose if y-axis should be in log-scale
%       y_label         label for y-axis
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

for i = 1:size(list_points,2)
    points = list_points(i);
    x = points.x;
    y = points.y;
    
    % If legend is present add it otherwise only plot without it
    if isfield(points, 'legend')
        plot(x,y,'DisplayName',points.legend, LineWidth=1) 
    else
        plot(x,y, LineWidth=1)
    end
    
    hold on 
end

title('Convergence plot')
xlabel('Number of Neurons') 

% If custom y_label is not provided
if ~exist('y_label', 'var')
    ylabel('relative gap sol') 
else
    ylabel(y_label)
end

% If log is not defined or if it is true then apply log transformation 
% to y-axis
if ~exist('y_log', 'var') || y_log
    a_plot = gca;
    a_plot.YScale = 'log';
end
hold off

% If legend exists then show legend in plot
if isfield(points, 'legend')
    legend show
end
end
