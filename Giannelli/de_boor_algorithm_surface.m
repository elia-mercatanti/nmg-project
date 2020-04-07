function [surface_point] = de_boor_algorithm_surface(control_points, ...
        order_1, order_2, knot_vector_1, knot_vector_2, t_1_star, t_2_star)
% DE_BOOR_ALGORITHM_SURFACE:
%   Implementation of De Boor algorithm for evaluating B-Spline surfaces, 
%   return the B-Spline point of a given degree and a knot vector 
%   corrisponding to a t_star parameter value.
% 
% Syntax: [surface_point] = de_boor_algorithm_surface(control_points,
%                           order_1, order_2, knot_vector_1, knot_vector_2,
%                           t_1_star, t_2_star)
%
% Input:
%   - control_points: (n+1 x m) matrix that contains all the control 
%                     points of the curve with m dimensions.
%   - order_1: degree of the B-Spline curve.
%   - order_2: degree of the B-Spline curve.
%   - knot_vector_1: knot vector of the B-Spline curve.
%   - knot_vector_2: knot vector of the B-Spline curve.
%   - t_1_star: parameter value in which i want to evaluate the base element.
%   - t_2_star: parameter value in which i want to evaluate the base element.
%
% Output:
%   - surface_point: estimated point of the B-Spline surface corresponding
%                    to t_star.
%
% Example: 
%   control_points = [0 0; 1 2; 3 2; 6 -1];
%   knot_vector_1: [0 0 0 1 1 1];
%   knot_vector_2: [0 0 0 1 1 1];
%   surface_point = de_boor_algorithm_surface(control_points, 3, 3, 
%                                 knot_vector_1, knot_vector_2, 0.5, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

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
