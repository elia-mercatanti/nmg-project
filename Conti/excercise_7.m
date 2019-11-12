% EXCERCISE_7:
%   Takes V0=(0,0,0), V1=(1,2,0), V2=(3,2,0), V3=(6,-1,0) as control points
%   of a cubic Bézier curve and builds one second cubic Bézier curve that
%   connects with continuity C^2 with the previus curve. Display the two 
%   curves and their respective control polygons.
%
% Requires:
%   - de_casteljau.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'Left Limit X Axis:', 'Right Limit X Axis:', ...
          'Left Limit Y Axis:', 'Right Limit Y Axis:', ...
          'Number of points of the Bézier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):'};
inputs_title = 'Inputs to Draw the Bézier Curve';
dimensions = [1 54];
default_inputs = {'-1', '15', '-15', '15', '1000', '0', '1'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
left_limit_x = str2double(inputs{1});
right_limit_x = str2double(inputs{2});
left_limit_y = str2double(inputs{3});
right_limit_y = str2double(inputs{4});
num_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});

% Initialize degree and control points of the first curve.
CP_1 = [0 0; 1 2; 3 2; 6 -1];
num_cp = length(CP_1);
degree = num_cp - 1;
CP_2 = zeros(num_cp, 2);

% Force C^0 continuity, calculate first point of the second curve.
CP_2(1, :) = CP_1(end, :);

% Calculate h_1 as the distance between the third and the fourth point of 
% the first curve, h_2 chosen at random
h_1 = norm(CP_1(end-1, :) - CP_1(end, :));
h_2 = randi(5);

% Force C^1 continuity, calculate second point of CP_2.
CP_2(2, :) = CP_1(end, :)/h_1*(h_1+h_2) - CP_1(end-1, :)*h_2/h_1;

% Force C^2 continuity, calculate third point of CP_2.
CP_2(3, :) = CP_2(2, :)*h_2/h_1 + CP_2(2, :) - CP_1(end-1, :)*h_2/h_1 ...
             - (CP_1(end-1, :)-CP_1(end-2, :))*(h_2)^2/(h_1^2);

% Calculate fourth point of CP_2, at random.
CP_2(4, :) = [12 randi(10)];

% Calculate the parameter (t) steps for drawing the Bézier curves.
steps = linspace(a, b, num_points);
if a ~= 0 || b~=1
    steps = (steps-a)/(b-a);
end

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 7', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Bézier Curve Connected to Another Curve');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([left_limit_x right_limit_x]);
ylim([left_limit_y right_limit_y]);

% Draw the control points plots for the two Bézier curve.
poi_plot_1 = plot(CP_1(:, 1), CP_1(:, 2), 'kx', 'MarkerSize', 10);
pol_plot_1 = plot(CP_1(:, 1), CP_1(:, 2), '-o', 'linewidth', 1, ...
                  'color', '#0072BD');
poi_plot_2 = plot(CP_2(:, 1), CP_2(:, 2), 'kx', 'MarkerSize', 10);
pol_plot_2 = plot(CP_2(:, 1), CP_2(:, 2), '-o', 'linewidth', 1, ...
                  'color', '#D95319');
      
legend([poi_plot_1 pol_plot_1 pol_plot_2], {'Control Points', ...
       'Control Polygon - First Curve', ...
       'Control Polygon - Second Curve'}, 'Location', 'best')

% Calculate and plot the first Bézier curve and control points.
bezier_curve = zeros(num_points, 2);
for i = 1 : num_points
    bezier_curve(i,:) = de_casteljau(CP_1, degree, steps(i));
end
plot(bezier_curve(:,1), bezier_curve(:,2), 'linewidth', 3, 'color', ...
     '#0072BD', 'DisplayName', 'First Bézier Curve');
 
% Calculate and plot the second Bézier curve and control points.
bezier_curve = zeros(num_points, 2);
for i = 1 : num_points
    bezier_curve(i,:) = de_casteljau(CP_2, degree, steps(i));
end
plot(bezier_curve(:,1), bezier_curve(:,2), 'linewidth', 3, 'color', ...
     '#D95319', 'DisplayName', 'Second Bézier Curve');  
