clear

% Inputs.
%p_x = [4 3 2; 4 3 2; 4 2 0];
%p_y = [4 4 4; 2 2 2; 0 0 0];
%p_z = [0 0 0; 2 3 2; 0 0 0];
p_x = [4.5 3.5 2.5; 4.5 3.5 2.5; 4.5 3.5 2.5];
p_y = [4.5 4.5 4.5; 3.5 3.5 3.5; 1.5 1.5 1.5];
p_z = [0 0 0;2.6 2.6 2.6; 0 0 0];
k_1 = 3;
k_2 = 3;
% Transform control points into a single matrix for applying
% transformations.
new_control_points = [reshape(p_x.', [], 1), reshape(p_y.', [], 1), ...
                      reshape(p_z.', [], 1)];
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

% Calculate tensor product and draw the b-spline surface.
surf_x = base_1*p_x*base_2.';
surf_y = base_1*p_y*base_2.';
surf_z = base_1*p_z*base_2.';
surf(surf_x , surf_y , surf_z);
hold on;

% Draw the control polygon of the b-spline surface.
plot3(p_x, p_y, p_z, 'b.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x', p_y', p_z', 'b--', 'linewidth', 2);

% Plot border curve.
plot3(surf_x(1, :), surf_y(1, :), surf_z(1, :), '-', 'linewidth', 10);
plot3(surf_x(:, 1), surf_y(:, 1), surf_z(:, 1), '-', 'linewidth', 10);
plot3(surf_x(end, :), surf_y(end, :), surf_z(end, :), '-', 'linewidth', 10);
plot3(surf_x(:, end), surf_y(:, end), surf_z(:, end), '-', 'linewidth', 10);
axis tight;
axis equal;
