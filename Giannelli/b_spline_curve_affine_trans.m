clear

% Inputs
left_limit_x = 0;
right_limit_x = 1;
left_limit_y = 0;
right_limit_y = 1;
num_points = 1000;
t = [0 0 0 0.3 0.6 1 1 1];
degree = 2;
control_points = [0.1 0.6; 0.3 0.9; 0.7 0.8; 0.8 0.5; 0.4 0.6];
num_cp = size(control_points, 1);

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
xlim([left_limit_x right_limit_x]);
ylim([left_limit_y right_limit_y]);

% Calculate the parameter (t) steps for drawing the B-Spline curves.
steps = linspace(t(degree+1), t(end-degree), num_points);

% Plot control points and control polygon.
poi_plot = plot(control_points(:, 1), control_points(:, 2), 'kx', ...
                'MarkerSize', 10);
pol_plot = plot(control_points(:, 1), control_points(:, 2), '-o', ...
                'linewidth', 1, 'color', '#0072BD');

% Calculate and plot the original B-Spline curve using De Boor algorithm.
curve = zeros(num_points, 2);
for i = 1 : num_points
    curve(i, :) = de_boor_algorithm(t, steps(i), degree, control_points);
end
original_curve = curve;
original_curve_plot = plot(curve(:, 1), curve(:, 2), 'linewidth', 3, ...
                           'color', '#D95319');
           
% Tranlation, rotation and scaling transformations.
T = [0.9 1];
R = [cos(pi) -sin(pi); sin(pi) cos(pi)];
S = [0.8 0; 0 0.8];

% Transformation on control points.
control_points = (control_points*R + T)*S;

% Plot transformed control points and control polygon.
plot(control_points(:, 1), control_points(:, 2), 'kx', 'MarkerSize', 10);
plot(control_points(:, 1), control_points(:, 2), '-o', 'linewidth', 1, ...
     'color', '#0072BD');

% Calculate and plot the transformed B-Spline curve.
for i = 1 : num_points
    curve(i, :) = de_boor_algorithm(t, steps(i), degree, control_points);
end
trasf_control_plot = plot(curve(:, 1), curve(:, 2), 'linewidth', 3, ...
                         'color', '#EDB120');

% Plot transformation on B-Spline curve points and legend.
original_curve = (original_curve*R + T)*S;
trasf_curve_plot = plot(original_curve(:, 1), original_curve(:, 2), ...
                         '--', 'linewidth', 3, 'color', '#7E2F8E');
legend([poi_plot pol_plot original_curve_plot ...
        trasf_control_plot trasf_curve_plot], 'Control Points', ...
        'Control Polygons', 'Original B-Spline Curve', ...
        'Transformations on Control Points', 'Transformations on Curve',...
        'Location', 'southeast');
