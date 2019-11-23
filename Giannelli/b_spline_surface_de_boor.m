% B_SPLINE_SURFACE_DE_BOOR:
%
% Requires:
%   - de_boor_algorithm.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Retrive inputs.
control_points = [4.5 4.5 0; 3.5 4.5 0; 2.5 4.5 0; 4.5 3.5 2.6; ...
                  3.5 3.5 2.6; 2.5 3.5 2.6; 4.5 1.5 0; 3.5 1.5 0; ...
                  2.5 1.5 0];
order_1 = 3;
order_2 = 3;
knot_vector_1 = [0 0 0 1 1 1];
knot_vector_2 = [0 0 0 1 1 1];
num_steps = 50;

% Initialization of the two basis matrices and steps to plot the surface.
steps_1 = linspace(knot_vector_1(order_1), knot_vector_1(end-order_1+1),...
                   num_steps);
steps_2 = linspace(knot_vector_2(order_2), knot_vector_2(end-order_2+1),...
                   num_steps);

% Calculate with de boor every point of the B-Spline surface.
surface_points = zeros(num_steps*num_steps, 3);
counter = 1;
for i = 1 : num_steps
    for j = 1 : num_steps
        surface_points(counter, :) = de_boor_algorithm_surface( ...
            control_points, order_1, order_2, knot_vector_1, ...
            knot_vector_2, steps_1(i), steps_2(j));
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

% Puts control points in three matrices (control grid).
control_grid_x = reshape(control_points(:, 1), order_1, order_2).';
control_grid_y = reshape(control_points(:, 2), order_1, order_2).';
control_grid_z = reshape(control_points(:, 3), order_1, order_2).';

% Plot the control grid of the B-Spline surface.
pol_plot = plot3(control_grid_x, control_grid_y, control_grid_z, ...
                 'b.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(control_grid_x.', control_grid_y.', control_grid_z.', 'b--', ...
      'linewidth', 2);
axis tight;
axis equal;
legend(pol_plot(1), {'Control Grid'}, 'Location', 'best');
