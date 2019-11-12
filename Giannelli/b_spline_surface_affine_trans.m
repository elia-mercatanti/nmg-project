clear

% Inputs.
p_x = [4.5 3.5 2.5; 4.5 3.5 2.5; 4.5 3.5 2.5];
p_y = [4.5 4.5 4.5; 3.5 3.5 3.5; 1.5 1.5 1.5];
p_z = [0 0 0;2.6 2.6 2.6; 0 0 0];
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

% Draw the original b-spline surface.
surf_x = base_1*p_x*base_2.';
surf_y = base_1*p_y*base_2.';
surf_z = base_1*p_z*base_2.';
surf(surf_x , surf_y , surf_z);
hold on;
grid on;

% Draw the original control polygon of the b-spline surface.
plot3(p_x, p_y, p_z, 'b.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x.', p_y.', p_z.', 'b--', 'linewidth', 2);

% Tranlation, rotatio and scale transformations.
T = [4 1 1];
R = [cos(pi/2) -sin(pi/2) 0; sin(pi/2) cos(pi/2) 0; 0 0 1];
S = [0.8 0 0; 0 0.8 0; 0 0 0.8];

% Transform control points into a single matrix for applying
% transformations.
new_control_points = [reshape(p_x.', [], 1), reshape(p_y.', [], 1), ...
                      reshape(p_z.', [], 1)];

% Transformation on control points.
new_control_points = (new_control_points*R + T)*S;

% Restore control points in three matrices.
p_x = reshape(new_control_points(:, 1), k_1, k_2).';
p_y = reshape(new_control_points(:, 2), k_1, k_2).';
p_z = reshape(new_control_points(:, 3), k_1, k_2).';

% Draw the transformed b-spline surface.
surf_x_trans = base_1*p_x*base_2.';
surf_y_trans = base_1*p_y*base_2.';
surf_z_trans = base_1*p_z*base_2.';
surf(surf_x_trans, surf_y_trans, surf_z_trans);

% Draw the control polygon of the b-spline surface.
plot3(p_x, p_y, p_z, 'r.-', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x.', p_y.', p_z.', 'r-', 'linewidth', 2);

% Transform surface points matrices into a single matrix for applying
% transformations.
surface_points = [reshape(surf_x.', [], 1), reshape(surf_y.', [], 1), ...
                  reshape(surf_z.', [], 1)];

% Transformation on surface points.
surface_points = (surface_points*R + T)*S;

% Restore surface points in three matrices.
surf_x = reshape(surface_points(:, 1), num_points, num_points).';
surf_y = reshape(surface_points(:, 2), num_points, num_points).';
surf_z = reshape(surface_points(:, 3), num_points, num_points).';

% Draw the transformed b-spline surface.
surf(surf_x , surf_y , surf_z, 'FaceAlpha', 0.5);

% Draw the control polygon of the b-spline surface.
plot3(p_x, p_y, p_z, 'g.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x.', p_y.', p_z.', 'g--', 'linewidth', 2);
axis tight;
axis equal;
