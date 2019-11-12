clear;

prompt = {'Left Limit X Axis:', 'Right Limit X Axis:', ...
          'Left Limit Y Axis:', 'Right Limit Y Axis:', ...
          'Number of points of the B-Spline curves to draw:', ...
          'Knocts Vector:', 'Degree:', 'Numbero of Control Points:'};
dlgtitle = 'Insert Inputs';
dims = [1 54];
definput = {'0', '1', '0', '1', '1000', '[0 0 0 0 0.5 1 1 1 1]', '3', '5'};
inputs = inputdlg(prompt, dlgtitle, dims, definput);
left_limit_x = str2double(inputs{1});
right_limit_x = str2double(inputs{2});
left_limit_y = str2double(inputs{3});
right_limit_y = str2double(inputs{4});
num_points = str2double(inputs{5});
t = str2num(inputs{6});
degree = str2double(inputs{7});
num_cp = str2double(inputs{8});

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 6', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Bézier Curve with Eleveted Degree');
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
    poi_plot = plot(control_points(i, 1), control_points(i, 2), 'kx', ...
         'MarkerSize', 10);
    if i > 1
        pol_plot = plot(control_points(i-1:i,1), control_points(i-1:i, ...
                        2), '-o', 'linewidth', 1, 'color', '#0072BD');
    end
end

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps = linspace(t(degree+1), t(end-degree), num_points);

% Calculate and plot the B-Spline curve using De Boor algorithm.
b_spline_curve = zeros(num_points, 2);
for i = 1 : num_points
    b_spline_curve(i, :) = de_boor_algorithm(t, steps(i), degree, control_points);
end
curve_plot = plot(b_spline_curve(:, 1), b_spline_curve(:, 2), 'linewidth', ...
                  3, 'color', '#D95319');
