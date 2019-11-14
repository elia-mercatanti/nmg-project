clear

% Inputs.
%p_x = [4 2 0; 4 3 2; 4 3 2];
%p_y = [4 4 4; 2 2 2; 0 0 0];
%p_z = [0 0 0; 2 3 2; 0 0 0];
p_x = [4.5 3.5 2.5; 4.5 3.5 2.5; 4.5 3.5 2.5];
p_y = [4.5 4.5 4.5; 3.5 3.5 3.5; 1.5 1.5 1.5];
p_z = [0 0 0;2.6 2.6 2.6; 0 0 0];
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
fig = figure('Name', 'B-Spline Surface with Tensor Product', ...
             'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');

% Calculate tensor product and draw the b-spline surface.
surf_x = first_base*p_x*second_base.';
surf_y = first_base*p_y*second_base.';
surf_z = first_base*p_z*second_base.';
surf(surf_x , surf_y , surf_z);
hold on;
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('B-Spline Surface with Tensor Product and Edge Curves');
axes = gca;

% Draw the control polygon of the b-spline surface.
pol_plot = plot3(p_x, p_y, p_z, 'b.--', 'linewidth', 2, 'MarkerSize', 25); 
plot3(p_x', p_y', p_z', 'b--', 'linewidth', 2);

% Plot edge curves and legend.
set(axes, 'ColorOrder', circshift(get(gca, 'ColorOrder'), -1))
edge_curve1_plot = plot3(surf_x(1, :), surf_y(1, :), surf_z(1, :), ...
                         'linewidth', 10);
edge_curve2_plot = plot3(surf_x(:, 1), surf_y(:, 1), surf_z(:, 1), ...
                         'linewidth', 10);
edge_curve3_plot = plot3(surf_x(end, :), surf_y(end, :), ...
                         surf_z(end, :), 'linewidth', 10);
edge_curve4_plot = plot3(surf_x(:, end), surf_y(:, end), ...
                         surf_z(:, end), 'linewidth', 10);
axis tight;
axis equal;
legend([pol_plot(1) edge_curve1_plot edge_curve2_plot edge_curve3_plot ...
        edge_curve4_plot], {'Control Polygon', 'First Edge Curve', ...
        'Second Edge Curve', 'Third Edge Curve', 'Fourth Edge Curve'}, ...
        'Location', 'best');
