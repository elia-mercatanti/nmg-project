% B_SPLINE_LOCALITY:
%  Test the locality property of a B-Spline curve.
%
% Requires:
%   - de_boor_algorithm.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Retrive inputs.
x_left_limit = 0;
x_right_limit = 1;
y_left_limit = 0;
y_right_limit = 1;
num_curve_points = 1000;
knot_vector = [0 0 0 0 0.25 0.25 0.5 0.5 0.75 0.75 1 1 1 1];
degree = 3;
control_points = [0.1, 0.1; 0.3, 0.4; 0.1, 0.6; 0.3, 0.9; 0.5, 0.3; ...
                  0.8, 0.9; 0.9, 0.6; 0.9, 0.3; 0.8, 0.2; 0.7, 0.1 ];

% Set the figure window for drawing plots.
fig = figure('Name', 'Locality Property 1', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Locality Property 1');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Get the order of the B-Spline curve.
order = degree + 1;

% Calculate the parameter (t) steps for drawing the B-Spline curves.
steps = linspace(knot_vector(order), knot_vector(end-degree), ...
                 num_curve_points);

% Plot control points and control polygon of the original curve.
plot(control_points(:, 1), control_points(:, 2), 'kx', 'MarkerSize', 10);
plot(control_points(:, 1), control_points(:, 2), '-', 'linewidth', 1, ...
     'color', '#0072BD');

% Calculate and plot the original B-Spline curve using De Boor algorithm.
curve = zeros(num_curve_points, 2);
for i = 1 : num_curve_points
    curve(i, :) = de_boor_algorithm(control_points, degree, ...
                                    knot_vector, steps(i));
end
plot(curve(:, 1), curve(:, 2), 'linewidth', 3, 'color', '#D95319');

% Control point modification.
control_point_mod = 5;
control_points(control_point_mod, :) = [0.5 0.6];

% Plot control points and control polygon of the modified curve.
plot(control_points(:, 1), control_points(:, 2), '-.o', 'linewidth', 1, ...
     'color', '#EDB120', 'MarkerEdgeColor', 'k', 'MarkerSize', 10);

% Calculate and plot the modified B-Spline curve.
for i = 1 : num_curve_points
    curve(i, :) = de_boor_algorithm(control_points, degree, ...
                                    knot_vector, steps(i));
end
plot(curve(:, 1), curve(:, 2), '--', 'linewidth', 3, 'color', '#77AC30');

% Plot lines for highlighting the modified interval.
left_line = de_boor_algorithm(control_points, degree, knot_vector, ...
                              knot_vector(control_point_mod));
right_line = de_boor_algorithm(control_points, degree, knot_vector, ...
                               knot_vector(control_point_mod+order));
plot([left_line(1) left_line(1)], [y_left_limit y_right_limit], 'k', ...
     'linewidth', 2)
plot([right_line(1) right_line(1)], [y_left_limit y_right_limit], 'k', ...
     'linewidth', 2)
legend({'Control Points', 'Original Control Polygon', ...
        'Original B-Spline Curve', 'Modified Control Polygon', ...
        'Modified B-Spline Curve', 'Sector of Change'}, 'Location', ...
        'south');
  