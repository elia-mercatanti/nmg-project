% EXCERCISE_7:
%   Takes V0=(0,0,0), V1=(1,2,0), V2=(3,2,0), V3=(6,-1,0) as control points
%   of a cubic B�zier curve and builds one second cubic B�zier curve that
%   connects with continuity C^2 with the previus curve. Display the two 
%   curves and their respective control polygons.
%
% Requires:
%   - de_casteljau.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for inputs.
prompt = {'X Axis Left Limit:', 'X Axis Right Limit:', ...
          'Y Axis Left Limit:', 'Y Axis Right Limit:', ...
          'Number of points of the B�zier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):'};
inputs_title = 'Inputs to Draw the B�zier Curve';
dimensions = [1 54];
default_inputs = {'-1', '15', '-15', '15', '1000', '0', '1'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
x_left_limit = str2double(inputs{1});
x_right_limit = str2double(inputs{2});
y_left_limit = str2double(inputs{3});
y_right_limit = str2double(inputs{4});
num_curve_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});

% Initialize degree and control points of the first curve.
cp_first_curve = [0 0; 1 2; 3 2; 6 -1];
num_control_points = size(cp_first_curve, 2);
cp_second_curve = zeros(num_control_points, 2);

% Force C^0 continuity, calculate first point of the second curve.
cp_second_curve(1, :) = cp_first_curve(end, :);

% Calculate h_1 as the distance between the third and the fourth point of 
% the first curve, h_2 chosen at random
h_1 = norm(cp_first_curve(end-1, :) - cp_first_curve(end, :));
h_2 = randi(5);

% Force C^1 continuity, calculate second point of CP_2.
cp_second_curve(2, :) = cp_first_curve(end, :)/h_1*(h_1+h_2) - ...
                        cp_first_curve(end-1, :)*h_2/h_1;

% Force C^2 continuity, calculate third point of CP_2.
cp_second_curve(3, :) = cp_second_curve(2, :)*h_2/h_1 + ...
                        cp_second_curve(2, :) - cp_first_curve(end-1, ...
                        :)*h_2/h_1 - (cp_first_curve(end-1, :) - ...
                        cp_first_curve(end-2, :))*(h_2)^2/(h_1^2);

% Calculate fourth point of CP_2, at random.
cp_second_curve(4, :) = [12 randi(10)];

% Calculate the parameter (t) steps for drawing the B�zier curves.
steps = linspace(a, b, num_curve_points);
if a ~= 0 || b~=1
    steps = (steps-a) / (b-a);
end

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 7', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('B�zier Curve Connected to Another Curve');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Draw the control points plots for the two B�zier curve.
poi_first_plot = plot(cp_first_curve(:, 1), cp_first_curve(:, 2), ...
                      'b.', 'MarkerSize', 20);
pol_first_plot = plot(cp_first_curve(:, 1), cp_first_curve(:, 2), '-', ...
                      'linewidth', 1, 'color', '#0072BD');
poi_second_plot = plot(cp_second_curve(:, 1), cp_second_curve(:, 2), ...
                       'r.', 'MarkerSize', 20);
pol_second_plot = plot(cp_second_curve(:, 1), cp_second_curve(:, 2), ...
                       '-', 'linewidth', 1, 'color', '#D95319');
      
legend([poi_first_plot pol_first_plot poi_second_plot pol_second_plot], ...
       {'Control Points - First Curve', 'Control Polygon - First Curve',...
       'Control Points - First Curve', ...
       'Control Polygon - Second Curve'}, 'Location', 'best')

% Calculate and plot the two B�zier curves.
first_bezier_curve = zeros(num_curve_points, 2);
second_bezier_curve = first_bezier_curve;
for i = 1 : num_curve_points
    t_star = steps(i);
    first_bezier_curve(i, :) = de_casteljau(cp_first_curve, t_star);
    second_bezier_curve(i, :) = de_casteljau(cp_second_curve, t_star);
end
plot(first_bezier_curve(:, 1), first_bezier_curve(:, 2), 'linewidth', ...
     3, 'color', '#0072BD', 'DisplayName', 'First B�zier Curve');
plot(second_bezier_curve(:, 1), second_bezier_curve(:, 2), 'linewidth', ...
     3, 'color', '#D95319', 'DisplayName', 'Second B�zier Curve');  
