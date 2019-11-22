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
prompt = {'X Axis Left Limit:', 'X Axis Right Limit:', ...
          'Y Axis Left Limit:', 'Y Axis Right Limit:', ...
          'Number of points of the Bézier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):' ...
          'Parameter value t* (Where the curve will be divided):'};
inputs_title = 'Inputs to Draw the Bézier Curves';
dimensions = [1 54];
default_inputs = {'0', '1', '0', '1', '1000', '0', '1', '0.5'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
x_left_limit = str2double(inputs{1});
x_right_limit = str2double(inputs{2});
y_left_limit = str2double(inputs{3});
y_right_limit = str2double(inputs{4});
num_curve_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});
t_star = str2double(inputs{8});

% Initialize degree and number of control points.
degree = 3;
num_control_points = degree + 1;
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
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Ask user to choose control vertices for the bezier_curve and plot them.
control_points = zeros(num_control_points, 2);
for i = 1 : num_control_points
    [x, y] = ginput(1);
    control_points(i, :) = [x, y];
    poi_plot = plot(control_points(i, 1), control_points(i, 2), 'k.', ...
                    'MarkerSize', 20);
    if i ~= 1
        pol_plot = plot(control_points(i-1:i, 1), control_points(i-1:i, ...
                        2), '-', 'linewidth', 1, 'color', '#0072BD');
    end
end
legend([poi_plot pol_plot],{'Control Points', 'Control Polygon'})

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps_first = linspace(a, t_star, num_curve_points);
steps_second = linspace(t_star, b, num_curve_points);
if a ~= 0 || b ~= 1 
    steps_first = (steps_first-a) ./ (b-a);
    steps_second = (steps_second-a) ./ (b-a);
    t_star = (t_star-a) / (b-a);
end 

% Run de Casteljau algorithm to draw the two curves control polygons.
[cp_first, cp_second] = de_casteljau_subdivision(control_points, t_star);
pol_first_plot = plot(cp_first(:, 1), cp_first(:, 2), '-', 'linewidth', ...
                      1, 'color', '#D95319');
plot(cp_first(:, 1), cp_first(:, 2), 'r.', 'MarkerSize', 20);
pol_second_plot = plot(cp_second(:, 1), cp_second(:, 2), '-', ...
                       'linewidth', 1, 'color', '#77AC30');
plot(cp_second(:, 1), cp_second(:, 2), 'g.', 'MarkerSize', 20);
legend([poi_plot pol_plot pol_first_plot pol_second_plot], ...
       {'Control Points', 'Original Control Polygon', ...
       'Control Polygon - First Curve', ...
       'Control Polygon - Second Curve'}, 'Location', 'best')

% Calculate and plot the first Bézier curve using de Casteljau algorithm.
bezier_curve = zeros(num_curve_points, 2);
for i = 1 : num_curve_points
    bezier_curve(i, :) = de_casteljau(cp_first, steps_first(i)/t_star);
end
plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, 'color', ...
     '#D95319', 'DisplayName', 'First Bézier Curve');  
 
% Calculate and plot the second Bézier curve using de Casteljau algorithm.
for i = 1 : num_curve_points
    bezier_curve(i, :) = de_casteljau(cp_second, (steps_second(i) - ...
                                      t_star)/(1-t_star));
end
plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, 'color', ...
     '#77AC30', 'DisplayName', 'Second Bézier Curve');  
 
% Check C^0 continuity
tol = 0.0001;
C0_continuity = abs(cp_first(end, :) - cp_second(1, :)) < tol;
disp(['C^0 Continuity: ', mat2str(all(C0_continuity))]);

% Check C^1 continuity
h_1 = original_t_star - a;
h_2 = b - original_t_star;
left_side = cp_first(end, :);
right_side = (h_1/(h_1+h_2)*cp_second(2, :) + h_2/(h_1+h_2)* ...
             cp_first(end-1, :));
C1_continuity = abs(left_side - right_side) < tol;
disp(['C^1 Continuity: ', mat2str(all(C1_continuity))]);

% Check C^2 continuity
left_side = cp_first(end-1, :) + h_2/h_1*(cp_first(end-1, :) - ...
            cp_first(end-2, :));
right_side = cp_second(2, :) + h_1/h_2*(cp_second(2, :)-cp_second(3, :));
C2_continuity = abs(left_side - right_side) < tol;
disp(['C^2 Continuity: ', mat2str(all(C2_continuity))]);

% Check C^3 continuity
delta_v_C1 = cp_first(end, :) - 3*cp_first(end-1, :) + ...
             3*cp_first(end-2, :) - cp_first(1, :);
delta_v_C2 = cp_second(4, :) - 3*cp_second(3, :) + 3*cp_second(2, :) ...
             - cp_second(1, :);
derivative3_C1 = factorial(degree)/factorial(degree-3)*delta_v_C1/(h_1)^3;
derivative3_C2 = factorial(degree)/factorial(degree-3)*delta_v_C2/(h_2)^3;
C3_continuity = abs(derivative3_C1 - derivative3_C2) < tol;
disp(['C^3 Continuity: ', mat2str(all(C3_continuity))]);
