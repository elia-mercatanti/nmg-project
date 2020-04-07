% B_SPLINE_CURVE_AFFINE_TRANS:
%   Apply some affine transformations to a B-Spline curve and plot the
%   results.
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
knot_vector = [0 0 0 0.3 0.6 1 1 1];
degree = 2;
control_points = [0.1 0.6; 0.3 0.9; 0.7 0.8; 0.8 0.5; 0.4 0.6];

% Set the figure window for drawing plots.
fig = figure('Name', 'B-spline Affine Transformations', 'NumberTitle', ...
             'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title(['B-spline Affine Transformations - Translation, Rotation and', ...
      ' Scaling']);
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Calculate the parameter (t) steps for drawing the B-Spline curves.
steps = linspace(knot_vector(degree+1), knot_vector(end-degree), ...
                 num_curve_points);

% Plot control points and control polygon.
poi_plot = plot(control_points(:, 1), control_points(:, 2), 'k.', ...
                'MarkerSize', 20);
pol_plot = plot(control_points(:, 1), control_points(:, 2), '-', ...
                'linewidth', 1, 'color', '#0072BD');

% Calculate and plot the original B-Spline curve using De Boor algorithm.
curve = zeros(num_curve_points, 2);
for i = 1 : num_curve_points
    curve(i, :) = de_boor_algorithm(control_points, degree, ...
                                    knot_vector, steps(i));
end
original_curve = curve;
original_curve_plot = plot(curve(:, 1), curve(:, 2), 'linewidth', 3, ...
                           'color', '#D95319');
           
% Tranlation, rotation and scaling transformations.
translation = [0.9 1];
rotation = [cos(pi) -sin(pi); sin(pi) cos(pi)];
scaling = [0.8 0; 0 0.8];

% Transformation on control points.
control_points = (control_points*rotation + translation)*scaling;

% Plot transformed control points and control polygon.
plot(control_points(:, 1), control_points(:, 2), 'k.', 'MarkerSize', 20);
plot(control_points(:, 1), control_points(:, 2), '-', 'linewidth', 1, ...
     'color', '#0072BD');

% Calculate and plot the transformed B-Spline curve on control points.
for i = 1 : num_curve_points
    curve(i, :) = de_boor_algorithm(control_points, degree, ...
                                    knot_vector, steps(i));
end
trasf_control_plot = plot(curve(:, 1), curve(:, 2), 'linewidth', 3, ...
                         'color', '#EDB120');

% Plot transformation on B-Spline curve points and legend.
original_curve = (original_curve*rotation + translation)*scaling;
trasf_curve_plot = plot(original_curve(:, 1), original_curve(:, 2), ...
                         '--', 'linewidth', 3, 'color', '#7E2F8E');
legend([poi_plot pol_plot original_curve_plot ...
        trasf_control_plot trasf_curve_plot], 'Control Points', ...
        'Control Polygons', 'Original B-Spline Curve', ...
        'Transformations on Control Points', 'Transformations on Curve',...
        'Location', 'southeast');
