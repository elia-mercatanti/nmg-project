% EXCERCISE_4:
%   Takes as input the coordinates of the control polygon of a cubic Bézier
%   curve and use de Casteljau algorithm to perform the subdivision of the 
%   curve given a parameter t_star chosen by the user. Display the control 
%   polygons of the two divided curves and verify that continuity C^3 
%   holds.
%
% Requires:
%   - de_casteljau.m
%   - de_casteljau_subdivision.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'Left Limit X Axis:', 'Right Limit X Axis:', ...
          'Left Limit Y Axis:', 'Right Limit Y Axis:', ...
          'Number of points of the Bézier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):' ...
          'Parameter t* (Where the curve will be divided):'};
inputs_title = 'Inputs to Draw the Bézier Curves';
dimensions = [1 54];
default_inputs = {'0', '1', '0', '1', '1000', '0', '1', '0.5'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
left_limit_x = str2double(inputs{1});
right_limit_x = str2double(inputs{2});
left_limit_y = str2double(inputs{3});
right_limit_y = str2double(inputs{4});
num_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});
t_star = str2double(inputs{8});

% Initialize degree and number of control points.
degree = 3;
num_cp = degree + 1;
original_t_star = t_star;

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 4', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Bézier Curve Subdivision');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([left_limit_x right_limit_x]);
ylim([left_limit_y right_limit_y]);

% Ask user to choose control vertices for the bezier_curve and plot them.
control_points = zeros(num_cp, 2);
for i = 1 : num_cp
    [x, y] = ginput(1);
    control_points(i, :) = [x, y];
    p1 = plot(control_points(i, 1), control_points(i, 2), 'kx', ...
         'MarkerSize', 10);
    if i ~= 1
        p2 = plot(control_points(i-1:i, 1), control_points(i-1:i,2), ...
             '-o', 'linewidth', 1, 'color', '#0072BD');
    end
end
legend([p1 p2],{'Control Points', 'Control Polygon'})

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps_1 = linspace(a, t_star, num_points);
steps_2 = linspace(t_star, b, num_points);
if a ~= 0 || b ~= 1 
    steps_1 = (steps_1-a) ./ (b-a);
    steps_2 = (steps_2-a) ./ (b-a);
    t_star = (t_star-a) / (b-a);
end 

% Run de Casteljau algorithm to draw the two curves control polygons.
[C1, C2] = de_casteljau_subdivision(control_points, degree, t_star);
poi_plot = plot(control_points(:, 1), control_points(:, 2), 'kx', ...
          'MarkerSize', 10);
pol_plot = plot(control_points(:, 1), control_points(:, 2), '-o', ...
          'linewidth', 1, 'color', '#0072BD');
pol_plot_1 = plot(C1(:, 1), C1(:, 2), '-o', 'linewidth', 1, 'color', ...
                  '#D95319');
plot(C1(:, 1), C1(:, 2), 'kx', 'MarkerSize', 10);
pol_plot_2 = plot(C2(:, 1), C2(:, 2), '-o', 'linewidth', 1, 'color', ...
                  '#77AC30');
plot(C2(:, 1), C2(:, 2), 'kx', 'MarkerSize', 10);
legend([poi_plot pol_plot pol_plot_1 pol_plot_2],{'Control Points', ...
       'Original Control Polygon', 'Control Polygon - First Curve', ...
       'Control Polygon - Second Curve'}, 'Location', 'best')

% Calculate and plot the first Bézier curve using de Casteljau algorithm.
bezier_curve = zeros(num_points, 2);
for i = 1 : num_points
    bezier_curve(i, :) = de_casteljau(C1, steps_1(i)/t_star);
end
plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, 'color', ...
     '#D95319', 'DisplayName', 'First Bézier Curve');  
 
% Calculate and plot the second Bézier curve using de Casteljau algorithm.
for i = 1 : num_points
    bezier_curve(i, :) = de_casteljau(C2, (steps_2(i)-t_star)/(1-t_star));
end
plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, 'color', ...
     '#77AC30', 'DisplayName', 'Second Bézier Curve');  
 
% Check C^0 continuity
tol = 0.0001;
C0_continuity = abs(C1(end, :) - C2(1, :)) < tol;
disp(['C^0 Continuity: ', mat2str(all(C0_continuity))]);

% Check C^1 continuity
h_1 = original_t_star - a;
h_2 = b - original_t_star;
left_side = C1(end, :);
right_side = (h_1/(h_1+h_2)*C2(2, :) + h_2/(h_1+h_2)*C1(end-1, :));
C1_continuity = abs(left_side - right_side) < tol;
disp(['C^1 Continuity: ', mat2str(all(C1_continuity))]);

% Check C^2 continuity
left_side = C1(end-1, :) + h_2/h_1*(C1(end-1, :)-C1(end-2, :));
right_side = C2(2, :) + h_1/h_2*(C2(2, :)-C2(3, :));
C2_continuity = abs(left_side - right_side) < tol;
disp(['C^2 Continuity: ', mat2str(all(C2_continuity))]);

% Check C^3 continuity
delta_v_C1 = C1(end, :) - 3*C1(end-1, :) + 3*C1(end-2, :) - C1(1, :);
delta_v_C2 = C2(4, :) - 3*C2(3, :) + 3*C2(2, :) - C2(1, :);
derivative3_C1 = factorial(degree)/factorial(degree-3)*delta_v_C1/(h_1)^3;
derivative3_C2 = factorial(degree)/factorial(degree-3)*delta_v_C2/(h_2)^3;
C3_continuity = abs(derivative3_C1 - derivative3_C2) < tol;
disp(['C^3 Continuity: ', mat2str(all(C3_continuity))]);
