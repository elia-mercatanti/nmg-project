% excercise_3:
%   Finds control points in the Bézier representation of the parametric 
%   with curve with equations X(t)=1+t+t^2; Y(t)=t^3 and with t in [0, 1],
%   display the control polygon and the relative Bézier curve.
%
% Requires:
%   - de_casteljau.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'Left Limit X Axis:', 'Right Limit X Axis:', ...
          'Left Limit Y Axis:', 'Right Limit Y Axis:', ...
          'Number of points of the Bézier curve to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):'};
inputs_title = 'Inputs to Draw the Bézier Curve';
dimensions = [1 54];
default_inputs = {'0.5', '3.5', '-0.5', '1.5', '1000', '0', '1'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
left_limit_x = str2double(inputs{1});
right_limit_x = str2double(inputs{2});
left_limit_y = str2double(inputs{3});
right_limit_y = str2double(inputs{4});
num_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});

% Initialize degree, control points and parametric equations of the curve.
degree = 3;
control_points = zeros(degree+1, 2);
syms t real;
x = 1 + t + t^2;
y = t^3;

% Calculate first and second derivative of the parametric equations.
x_first_derivative = diff(x);
y_first_derivative = diff(y);
x_second_derivative = diff(x_first_derivative);
y_second_derivative = diff(y_first_derivative);

% Calculate first control point using parametric equations.
control_points(1, 1) = subs(x, t, 0);
control_points(1, 2) = subs(y, t, 0);

% Calculate second control point using first derivative.
j_derivative = 1;
control_points(2, 1) = subs(x_first_derivative, 0)/(factorial(degree)/ ...
                       factorial(degree-j_derivative)) + ...
                       control_points(1, 1);
control_points(2, 2) = subs(y_first_derivative, 0)/(factorial(degree)/ ...
                       factorial(degree-j_derivative)) + ...
                       control_points(1, 2); 

% Calculate third control point using second derivative.
j_derivative = 2;
control_points(3, 1) = subs(x_second_derivative, 0)/(factorial(degree)/ ...
                       factorial(degree-j_derivative)) - ...
                       control_points(1, 1) + 2*control_points(2, 1);
control_points(3, 2) = subs(y_second_derivative, 0)/(factorial(degree)/ ...
                       factorial(degree-j_derivative)) - ...
                       control_points(1, 2) + 2*control_points(2, 2);

% Calculate fourth control point using parametric equations.
control_points(4, 1) = subs(x, t, 1);
control_points(4, 2) = subs(y, t, 1);

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 3', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('Bézier Curve and Control Polygon');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([left_limit_x right_limit_x]);
ylim([left_limit_y right_limit_y]);

% Plot control polygon.
plot_1 = plot(control_points(:, 1), control_points(:, 2), 'kx', ...
          'MarkerSize', 10);
plot_2 = plot(control_points(:, 1), control_points(:, 2), '-o', ...
          'linewidth', 1, 'color', '#0072BD');
legend([plot_1 plot_2],{'Control Points', 'Control Polygon'}, ...
       'Location', 'northwest')

% Calculate the parameter (t) steps for drawing the Bézier curve.
steps = linspace(a, b, num_points);
if a ~= 0 || b ~= 1
    steps = (steps-a) / (b-a);
end

% Calculate and plot the Bézier curve using de Casteljau algorithm.
bezier_curve = zeros(num_points, 2);
for i = 1 : num_points
    bezier_curve(i, :) = de_casteljau(control_points, degree, steps(i));
end
plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', 3, 'color', ...
     '#D95319', 'DisplayName', 'Bézier Curve');
 