function [surface_point] = de_boor_algorithm_surface(control_points, ...
        order_1, order_2, knot_vector_1, knot_vector_2, t_1_star, t_2_star)
             
    % Uses order_1 times de Boor algorithm to calculate order_1 points.
    Q = zeros(order_1, 3);
    for i = 1 : order_1
        Q(i, :) =  de_boor_algorithm(control_points(order_2*(i-1)+1: ...
                                     order_2*i, :), order_2-1, ...
                                     knot_vector_2, t_2_star);
    end
    
    % Uses de Boor algorithm on Q to calculate the final surface point.
    surface_point = de_boor_algorithm(Q, order_1-1, knot_vector_1, ...
                                      t_1_star);
end
