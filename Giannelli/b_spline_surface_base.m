clear

% Ask user for input.
prompt = {'Order 1:', 'Knocts Vector 1:', 'Order 2:', 'Knocts Vector 2:'};
inputs_title = 'Insert Inputs';
dimensions = [1 54];
default_inputs = {'3', '[0 0 0 1 1 1]', '3', '[0 0 0 1 1 1]'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
k_1 = str2double(inputs{1});
t_1 = str2num(inputs{2});
k_2 = str2double(inputs{3});
t_2 = str2num(inputs{4});
num_points = 100;

% Init
steps_1 = linspace(t_1(k_1), t_1(end-k_1+1), num_points);
steps_2 = linspace(t_2(k_2), t_2(end-k_2+1), num_points);
num_base1_elements = length(t_1) - k_1;
num_base2_elements = length(t_2) - k_2; 
base_1 = zeros(num_points, num_base1_elements);
base_2 = zeros(num_points, num_base2_elements);

% Get the first base.
for i = 1 : num_points
    for j = 1 : num_base1_elements
        base_1(i, j) = cox_de_boor(j, k_1, t_1, steps_1(i), k_1);
    end
end

% Get the second base.
for i = 1 : num_points
    for j = 1 : num_base2_elements
        base_2(i, j) = cox_de_boor(j, k_1, t_2, steps_2(i), k_2);
    end
end

% Draw the b-spline surface.
for i = 1 : num_base1_elements
    for j = 1 : num_base2_elements
        Z = base_1(:, i)*base_2(:, j).';
        surf (steps_1, steps_2, Z); 
        hold on;
    end
end