clear

% Inputs.
%p_x = [4 3 2; 4 3 2; 4 2 0];
%p_y = [4 4 4; 2 2 2; 0 0 0];
%p_z = [0 0 0; 2 3 2; 0 0 0];
p_x = [4.5 3.5 2.5; 4.5 3.5 2.5; 4.5 3.5 2.5; 4.5 3.5 2.5];
p_y = [4.5 4.5 4.5; 3.5 3.5 3.5; 1.5 1.5 1.5; 1.5 1.5 1.5];
p_z = [0 0 0;2.6 2.6 2.6; 0 0 0; 0 0 0];
control_points = [reshape(p_x.', [], 1), reshape(p_y.', [], 1), ...
                  reshape(p_z.', [], 1)];
k_1 = 3;
k_2 = 3;
t_1 = [0 0 0 1 1 1];
t_2 = [0 0 0 1 1 1];
num_steps = 50;

% Initialization
steps_1 = linspace(t_1(k_1), t_1(end-k_1+1), num_steps);
steps_2 = linspace(t_2(k_2), t_2(end-k_2+1), num_steps);
num_base1_elements = length(t_1) - k_1;
num_base2_elements = length(t_2) - k_2; 

% Calculate with de boor every point of the b-spline surface.
surface_points = zeros(num_steps*num_steps, 3);
counter = 1;
for i = 1 : num_steps
    for j = 1 : num_steps
        surface_points(counter, :) = de_boor_algorithm_surface(t_1, ...
                                     t_2, steps_1(i), steps_2(j), k_1, ...
                                     k_2, control_points);
        counter = counter + 1;
    end
end

% Set the figure window for drawing plots.
fig = figure('Name', 'B-Spline Surface with De Boor', ...
             'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');

% Plot the b-spline surface.
surface_matrix_x = reshape(surface_points(:, 1), num_steps, num_steps).';
surface_matrix_y = reshape(surface_points(:, 2), num_steps, num_steps).';
surface_matrix_z = reshape(surface_points(:, 3), num_steps, num_steps).';
surf(surface_matrix_x, surface_matrix_y, surface_matrix_z);
hold on;
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('B-Spline Surface with De Boor');

% Draw the control polygon of the b-spline surface.
pol_plot = plot3(p_x, p_y, p_z, 'b.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x.', p_y.', p_z.', 'b--', 'linewidth', 2);
axis tight;
axis equal;
legend([pol_plot(1)], {'Control Polygon'}, 'Location', 'best');
