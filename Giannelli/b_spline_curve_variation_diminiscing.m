clear

% Inputs
num_points = 1000;
t = [0 0 0 0 0.25 0.25 0.5 0.5 0.75 0.75 1 1 1 1];
degree = 3;
control_points = [0.1, 0.1; 0.3, 0.4; 0.1, 0.6; 0.3, 0.9; 0.5, 0.1; ...
                  0.8, 0.9; 0.9, 0.6; 0.9, 0.3; 0.8, 0.2; 0.7, 0.1 ];
num_cp = size(control_points, 1);

% Set the figure window for drawing plots.
fig = figure('Name', 'Variation Diminiscing', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Variation Diminiscing');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([0 1]);
ylim([0 1]);

% Calculate the parameter (t) steps for drawing the B-Spline curves.
steps = linspace(t(degree+1), t(end-degree), num_points);

% Plot control points and control polygon of the original curve.
plot(control_points(:, 1), control_points(:, 2), 'kx', 'MarkerSize', 10);
plot(control_points(:, 1), control_points(:, 2), '-o', 'linewidth', 1, ...
     'color', '#0072BD');

% Calculate and plot the original B-Spline curve using De Boor algorithm.
curve = zeros(num_points, 2);
for i = 1 : num_points
    curve(i, :) = de_boor_algorithm(t, steps(i), degree, control_points);
end
plot(curve(:, 1), curve(:, 2), 'linewidth', 3, 'color', '#D95319');

% Generate random line to intersect with the curve.
y = 0.1 + (0.8-0.1).*rand(1, 2);
plot([0 1], y, 'k', 'linewidth', 2);
legend({'Control Points', 'Control Polygon', 'B-Spline Curve', ...
        'Intersecting Line'}, 'Location', 'best');