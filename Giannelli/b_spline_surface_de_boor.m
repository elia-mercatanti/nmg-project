clear

% Inputs.
%p_x = [4 3 2; 4 3 2; 4 2 0];
%p_y = [4 4 4; 2 2 2; 0 0 0];
%p_z = [0 0 0; 2 3 2; 0 0 0];

p_x = [4.5 3.5 2.5; 4.5 3.5 2.5; 4.5 3.5 2.5];
p_y = [4.5 4.5 4.5; 3.5   3.5  3.5; 1.5 1.5 1.5];
p_z = [0    0   0;   2.6 2.6 2.6; 0 0 0];
control_points = [reshape(p_x.', [], 1), reshape(p_y.', [], 1), ...
                  reshape(p_z.', [], 1)];
k_1 = 3;
k_2 = 3;
t_1 = [0 0 0 1 1 1];
t_2 = [0 0 0 1 1 1];
num_points = 100;

% Initialization
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

% Calculate with de boor every point of the b-spline surface.
surface_points = zeros(num_points*num_points, 3);
counter = 1;
for i = 1 : num_points
    for j = 1 : num_points
        surface_points(counter, :) = de_boor_algorithm_surface(t_1, ...
                                     t_2, steps_1(i), steps_2(j), k_1, ...
                                     k_2, control_points);
        counter = counter + 1;
    end
end

% Plot the b-spline surface.
surface_matrix_x = reshape(surface_points(:, 1), num_points, num_points).';
surface_matrix_y = reshape(surface_points(:, 2), num_points, num_points).';
surface_matrix_z = reshape(surface_points(:, 3), num_points, num_points).';
surf(surface_matrix_x, surface_matrix_y, surface_matrix_z);
hold on;
grid on;

% Draw the control polygon of the b-spline surface.
plot3(p_x, p_y, p_z, 'b.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x.', p_y.', p_z.', 'b--', 'linewidth', 2);
axis tight;
axis equal;