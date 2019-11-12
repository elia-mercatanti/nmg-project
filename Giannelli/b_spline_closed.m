clear;

prompt = {'Left Limit X Axis:', 'Right Limit X Axis:', ...
          'Left Limit Y Axis:', 'Right Limit Y Axis:', ...
          'Number of points of the B-Spline curves to draw:', ...
          'Degree:', 'Numbero of Control Points (Last one automatically generated, V_1=V_n):'};
dlgtitle = 'Insert Inputs';
dims = [1 54];
definput = {'0', '1', '0', '1', '1000', '2', '5'};
inputs = inputdlg(prompt, dlgtitle, dims, definput);
left_limit_x = str2double(inputs{1});
right_limit_x = str2double(inputs{2});
left_limit_y = str2double(inputs{3});
right_limit_y = str2double(inputs{4});
num_points = str2double(inputs{5});
degree = str2double(inputs{6});
num_cp = str2double(inputs{7});

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
control_points = zeros(num_cp + degree + 2, 2);
for i = 1 : num_cp + 1
    if i > num_cp
        % Generate last control point V_1=V_n.
        control_points(num_cp + 1, :) = control_points(1, :);
    else
        [x, y] = ginput(1);
        control_points(i, :) = [x, y];
    end
    plot(control_points(i, 1), control_points(i, 2), 'kx', ....
          'MarkerSize', 10);
    if i > 1
        plot(control_points(i-1:i,1), control_points(i-1:i, 2), '-o', 'linewidth', 1, 'color', '#0072BD');      
    end
end     
% Generate knot vector.
t = -(degree+1)/num_cp : 1/num_cp : (degree+1+num_cp)/num_cp;
control_points(end, :) = control_points(1, :);

% Generate last k (order) control points.
control_points(num_cp+2: end, :) = control_points(2:degree+2, :);
plot(control_points(num_cp+2: end, 1), control_points(num_cp+2: end, 2), 'g.', 'MarkerSize', 20);
plot(control_points(i-1:i,1), control_points(i-1:i, 2), '-o', 'linewidth', 1, 'color', '#0072BD');      

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps = linspace(t(degree+1), t(end-degree), num_points);

% Calculate and plot the B-Spline curve using De Boor algorithm.
b_spline_curve = zeros(num_points, 2);
for i = 1 : num_points
    b_spline_curve(i, :) = de_boor_algorithm(t, steps(i), degree, control_points);
end
curve_plot = plot(b_spline_curve(:, 1), b_spline_curve(:, 2), 'linewidth', ...
                  3, 'color', '#D95319');
              