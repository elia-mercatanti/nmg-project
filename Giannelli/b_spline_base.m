% B_SPLINE_BASE:
%   Takes as input the coordinates of the control polygon of a cubic
%   Bézier curve use the degree elevation algorithm to find the control 
%   polygons of this curve elevated to 4, 5, 6 degrees and draws them.
%
% Requires:
%   - cox_de_boor.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'Order:', 'Knocts vector:'};
inputs_title = 'Insert Inputs';
dimensions = [1 54];
default_inputs = {'3', '[0 0 0 1 1 1]'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
order = str2double(inputs{1});
t = str2num(inputs{2});
num_points = 1000;

% Init
steps = linspace(t(order), t(end-order+1), num_points);
base_y = zeros(1, num_points);
hold on;
grid on;

for i = 1 : length(t)-order
    for j = 1 : num_points
        base_y(j) = cox_de_boor(i, order, t, steps(j), order);
    end
    plot(steps, base_y, 'linewidth', 2);
end
