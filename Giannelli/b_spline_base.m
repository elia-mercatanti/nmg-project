% B_SPLINE_BASE:
%   Takes as input the order and a knot vector to evaluate and plot all
%   elements of the relative B-Spline base, using Cox-de Boor recursion
%   formula.
%
% Requires:
%   - cox_de_boor.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for inputs.
prompt = {'Order:', 'Knocts Vector:'};
inputs_title = 'Insert Inputs';
dimensions = [1 50];
default_inputs = {'3', '[0 0 0 1 1 1]'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
order = str2double(inputs{1});
knot_vector = str2num(inputs{2});
num_curve_points = 1000;

% Initialize steps and vector of evaluations for drawing base curve.
steps = linspace(knot_vector(1), knot_vector(end), num_curve_points);
base_element = zeros(1, num_curve_points);

% Set the figure window for drawing plots.
fig = figure('Name', 'B-Spline Base', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('B-Spline Base');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';

% Calculate and plot curves for the elements of the base using 
% Cox-de Boor recursion formula.
for i = 1 : length(knot_vector) - order
    for j = 1 : num_curve_points
        base_element(j) = cox_de_boor(i, order, order, knot_vector, ...
                                      steps(j));
    end
    ordinal = iptnum2ordinal(i);
    plot(steps, base_element, 'linewidth', 3, 'DisplayName', ...
         [upper(ordinal(1)), ordinal(2:min(end)) ' Base Element']);
end
legend('Location', 'best');
