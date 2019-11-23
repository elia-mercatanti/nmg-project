% B_SPLINE_SURFACE_BASE:
%
% Requires:
%   - cox_de_boor.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for inputs.
prompt = {'First Base Order:', 'First Base Knocts Vector:', ...
          'Second Base Order:', 'Second Base Knocts Vector:'};
inputs_title = 'Insert Inputs';
dimensions = [1 54];
default_inputs = {'3', '[0 0 0 1 1 1]', '3', '[0 0 0 1 1 1]'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
order_1 = str2double(inputs{1});
knot_vector_1 = str2num(inputs{2});
order_2 = str2double(inputs{3});
knot_vector_2 = str2num(inputs{4});
num_steps = 50;

% Initialization of the two basis matrices and steps to plot the surface.
steps_1 = linspace(knot_vector_1(order_1), knot_vector_1(end-order_1+1),...
                   num_steps);
steps_2 = linspace(knot_vector_2(order_2), knot_vector_2(end-order_2+1),...
                   num_steps);
num_base1_elements = length(knot_vector_1) - order_1;
num_base2_elements = length(knot_vector_2) - order_2; 
first_base = zeros(num_steps, num_base1_elements);
second_base = zeros(num_steps, num_base2_elements);

% Calcualte the first B-Spline base.
for i = 1 : num_steps
    for j = 1 : num_base1_elements
        first_base(i, j) = cox_de_boor(j, order_1, order_1, ...
                                       knot_vector_1, steps_1(i));
    end
end

% Calcualte the second B-Spline base.
for i = 1 : num_steps
    for j = 1 : num_base2_elements
        second_base(i, j) = cox_de_boor(j, order_2, order_2, ...
                                        knot_vector_2, steps_2(i));
    end
end

% Set the figure window for drawing plots.
fig = figure('Name', 'B-Spline Surface Base', ...
             'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');

% Plot the B-Spline surface.
for i = 1 : num_base1_elements
    for j = 1 : num_base2_elements
        Z = first_base(:, i)*second_base(:, j).';
        surf(steps_1, steps_2, Z); 
        hold on;
    end
end
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('B-Spline Surface Base');
