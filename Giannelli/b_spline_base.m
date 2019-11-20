% B_SPLINE_BASE:
%
% Requires:
%   - cox_de_boor.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'Order:', 'Knocts vector:'};
inputs_title = 'Insert Inputs';
dimensions = [1 50];
default_inputs = {'3', '[0 0 0 1 1 1]'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
order = str2double(inputs{1});
t = str2num(inputs{2});
num_points = 1000;

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

% Initialization
steps = linspace(t(1), t(end), num_points);
base_y = zeros(1, num_points);

for i = 1 : length(t) - order
    for j = 1 : num_points
        base_y(j) = cox_de_boor(i, order, t, steps(j), order);
    end
    ordinal = iptnum2ordinal(i);
    plot(steps, base_y, 'linewidth', 2, 'DisplayName', ...
         [upper(ordinal(1)), ordinal(2:min(end)) ' Base Element']);
end
legend('Location', 'best');
