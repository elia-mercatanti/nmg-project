% B_SPLINE_CLOSED:
%
% Requires:
%   - de_boor_algorithm.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for inputs.
prompt = {'X Axis Left Limit:', 'X Axis Right Limit:', ...
          'Y Axis Left Limit:', 'Y Axis Right Limit:', ...
          ['Number of Control Points (Last one automatically' ...
          ' generated, V_1=V_n):'], 'Degree:', ...
          'Number of points of the B-Spline curves to draw:'};
inputs_title = 'Insert Inputs';
dimensions = [1 56];
default_inputs = {'0', '1', '0', '1', '5', '2', '1000'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);
x_left_limit = str2double(inputs{1});
x_right_limit = str2double(inputs{2});
y_left_limit = str2double(inputs{3});
y_right_limit = str2double(inputs{4});
num_control_points = str2double(inputs{5});
degree = str2double(inputs{6});
num_curve_points = str2double(inputs{7});

% Get the order of the B-Spline curve.
order = degree + 1;

% Set the figure window for drawing plots.
fig = figure('Name', 'Closed B-Spline', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Closed B-Spline');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Ask user to choose control vertices for the B-Spline curve and plot them.
control_points = zeros(num_control_points + degree + 2, 2);
for i = 1 : num_control_points + 1
    if i > num_control_points
        % Generate last control point V_1=V_n.
        control_points(num_control_points + 1, :) = control_points(1, :);
    else
        control_points(i, :) = ginput(1);
    end
    poi_plot = plot(control_points(i, 1), control_points(i, 2), 'k.', ...
                    'MarkerSize', 20);
    if i > 1
        pol_plot = plot(control_points(i-1:i,1), control_points(i-1:i, ...
                        2), '-', 'linewidth', 1, 'color', '#0072BD');   
    end
end
legend([poi_plot pol_plot], {'Control Point', 'Control Polygon'}, ...
       'Location', 'best');

% Generate knot vector.
knot_vector = -order/num_control_points : 1/num_control_points : ...
    (order+num_control_points)/num_control_points;
control_points(end, :) = control_points(1, :);

% Generate last k (order) control points and plot them.
control_points(num_control_points+2:end, :) = control_points(2:degree+2,:);
plot(control_points(num_control_points+2: end, 1), ...
                    control_points(num_control_points+2: end, 2), 'g.', ...
                    'MarkerSize', 20, 'DisplayName', ...
                    'New Added Control Points');

% Calculate the parameter (t) steps for drawing the B-Spline curves.
steps = linspace(knot_vector(order), knot_vector(end-degree), ...
                 num_curve_points);

% Calculate and plot the B-Spline curve using de Boor algorithm.
curve = zeros(num_curve_points, 2);
for i = 1 : num_curve_points
    curve(i, :) = de_boor_algorithm(control_points, degree, ...
                                    knot_vector, steps(i));
end
plot(curve(:, 1), curve(:, 2), 'linewidth', 3, 'color', '#D95319', ...
     'DisplayName', 'B-Spline Curve');
