clear

% Ask user for input.
prompt = {'First Base Order:', 'First Base Knocts Vector:', ...
          'Second Base Order:', 'Second Base Knocts Vector:'};
inputs_title = 'Insert Inputs';
dimensions = [1 54];
default_inputs = {'3', '[0 0 0 1 1 1]', '3', '[0 0 0 1 1 1]'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
k_1 = str2double(inputs{1});
t_1 = str2num(inputs{2});
k_2 = str2double(inputs{3});
t_2 = str2num(inputs{4});
num_steps = 50;

% Initialization.
steps_1 = linspace(t_1(k_1), t_1(end-k_1+1), num_steps);
steps_2 = linspace(t_2(k_2), t_2(end-k_2+1), num_steps);
num_base1_elements = length(t_1) - k_1;
num_base2_elements = length(t_2) - k_2; 
first_base = zeros(num_steps, num_base1_elements);
second_base = zeros(num_steps, num_base2_elements);

% Get the first base.
for i = 1 : num_steps
    for j = 1 : num_base1_elements
        first_base(i, j) = cox_de_boor(j, k_1, t_1, steps_1(i), k_1);
    end
end

% Get the second base.
for i = 1 : num_steps
    for j = 1 : num_base2_elements
        second_base(i, j) = cox_de_boor(j, k_1, t_2, steps_2(i), k_2);
    end
end

% Set the figure window for drawing plots.
fig = figure('Name', 'B-Spline Surface Base', ...
             'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');

% Draw the b-spline surface.
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