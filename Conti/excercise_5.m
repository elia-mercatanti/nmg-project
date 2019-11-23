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

% Ask user for inputs.
prompt = {'X Axis Left Limit:', 'X Axis Right Limit:', ...
          'Y Axis Left Limit:', 'Y Axis Right Limit:', ...
          'Number of points of the Bézier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):' ...
          'Parameter l (Number of times to repeat V2):'};
inputs_title = 'Inputs to Draw the Bézier Curves';
dimensions = [1 54];
default_inputs = {'0', '1', '0', '1', '1000', '0', '1', '1'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
x_left_limit = str2double(inputs{1});
x_right_limit = str2double(inputs{2});
y_left_limit = str2double(inputs{3});
y_right_limit = str2double(inputs{4});
num_curve_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});
l = str2double(inputs{8});

% Initialize number of control points.
num_control_points = 4;

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
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Ask user to choose control vertices for the Bézier curve and plot them.
control_points = zeros(num_control_points, 2);
for i = 1 : num_control_points
    control_points(i, :) = ginput(1);
    poi_plot = plot(control_points(i, 1), control_points(i, 2), 'k.', ...
                    'MarkerSize', 20);
    if i ~= 1
        pol_plot = plot(control_points(i-1:i,1), control_points(i-1:i, ...
                        2), '-', 'linewidth', 1, 'color', '#0072BD');
    end
end
legend([poi_plot pol_plot],{'Control Points', 'Control Polygon'}, ...
       'Location', 'best');

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps = linspace(a, b, num_curve_points);
if a ~= 0 || b ~= 1
    steps = (steps-a) / (b-a);
end

% Calculate and plot the Bézier curves adding each time another V2.
bezier_curve = zeros(num_curve_points, 2);
set(gca, 'ColorOrder', circshift(get(gca, 'ColorOrder'), -1))
for i = 0:l
    if (i > 0)
        control_points = [control_points(1:2,:); control_points(3, :); ...
                          control_points(3:end, :)];
    end
    
    for j = 1 : num_curve_points
        bezier_curve(j, :) = de_casteljau(control_points, steps(j));
    end
    order = iptnum2ordinal(i+1);
    plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, ...
         'DisplayName', [upper(order(1)), order(2:min(end)) ...
         ' Bézier Curve']);
end
