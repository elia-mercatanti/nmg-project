% EXCERCISE_5:
%   Starting from a cubic Bézier curve defined by vertices V0, V1, V2, V3, 
%   build grade l+3 Bézier curves, with 1>=1, whose control polygon is the
%   polygon V0, V1, V2 -- l times -- V2, V3. Shows an examples.
%
% Requires:
%   - de_casteljau.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'Left Limit X Axis:', 'Right Limit X Axis:', ...
          'Left Limit Y Axis:', 'Right Limit Y Axis:', ...
          'Number of points of the Bézier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):' ...
          'Parameter l (Number of times to repeat V2):'};
inputs_title = 'Inputs to Draw the Bézier Curves';
dimensions = [1 54];
default_inputs = {'0', '1', '0', '1', '1000', '0', '1', '1'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
left_limit_x = str2double(inputs{1});
right_limit_x = str2double(inputs{2});
left_limit_y = str2double(inputs{3});
right_limit_y = str2double(inputs{4});
num_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});
l = str2double(inputs{8});

% Initialize degree and number of control points.
degree = 3;
num_cp = degree + 1;

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 5', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Bézier Curve with Repeated Point V2');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([left_limit_x right_limit_x]);
ylim([left_limit_y right_limit_y]);

% Ask user to choose control vertices for the Bézier curve and plot them.
control_points = zeros(num_cp, 2);
for i = 1 : num_cp
    [x, y] = ginput(1);
    control_points(i, :) = [x, y];
    plot_1 = plot(control_points(i, 1), control_points(i, 2), 'kx', ...
         'MarkerSize', 10);
    if i ~= 1
        plot_2 = plot(control_points(i-1:i,1), control_points(i-1:i,2), ...
             '-o', 'linewidth', 1, 'color', '#0072BD');
    end
end
legend([plot_1 plot_2],{'Control Points', 'Control Polygon'}, ...
       'Location', 'best');

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps = linspace(a, b, num_points);
if a ~= 0 || b ~= 1
    steps = (steps-a) / (b-a);
end

% Calculate and plot the Bézier curves adding each time another V2.
bezier_curve = zeros(num_points, 2);
set(gca, 'ColorOrder', circshift(get(gca, 'ColorOrder'), numel(plot_2)-2))
for i = 0:l
    if (i > 0)
        control_points = [control_points(1:3-1,:); control_points(3, :);...
                          control_points(3:end, :)];
    end
    
    for j = 1 : num_points
        bezier_curve(j, :) = de_casteljau(control_points, steps(j));
    end
    order = iptnum2ordinal(i+1);
    plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, ...
         'DisplayName', [upper(order(1)), order(2:min(end)) ...
         ' Bézier Curve']);
end
