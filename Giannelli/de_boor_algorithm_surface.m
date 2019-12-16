function [surface_point] = de_boor_algorithm_surface(control_points, ...
        order_1, order_2, knot_vector_1, knot_vector_2, t_1_star, t_2_star)
             
    % Uses n times de Boor algorithm to calculate n points.
    n = length(knot_vector_1) - order_1;
    m = length(knot_vector_2) - order_2;
    Q = zeros(n, 3);
    for i = 1 : n
        Q(i, :) =  de_boor_algorithm(control_points(m*(i-1)+1: m*i, :), ...
                                     order_2-1, knot_vector_2, t_2_star);
    end
    
    % Uses de Boor algorithm on Q to calculate the final surface point.
    surface_point = de_boor_algorithm(Q, order_1-1, knot_vector_1, ...
                                      t_1_star);
end
