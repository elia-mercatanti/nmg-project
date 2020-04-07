function [curve_point] = de_boor_algorithm(control_points, degree, ...
                                           knot_vector, t_star)
% DE_BOOR_ALGORITHM:
%   Implementation of De Boor algorithm for evaluating B-Spline, return 
%   the B-Spline point of a given degree and a knot vector corrisponding to
%   a t_star parameter value.
% 
% Syntax: [curve_point] = de_boor_algorithm(control_points, degree, 
%                                           knot_vector, t_star)
%
% Input:
%   - control_points: (n+1 x m) matrix that contains all the control 
%                     points of the curve with m dimensions.
%   - degree: degree of the B-Spline curve.
%   - knot_vector: knot vector of the B-Spline curve.
%   - t_star: parameter value in which i want to evaluate the base element.
%
% Output:
%   - curve_point: estimated point of the B-Spline curve corresponding to 
%                  t_star.
%
% Example: 
%   control_points = [0 0; 1 2; 3 2; 6 -1];
%   knot_vector = [0 0 0 1 1 1];
%   curve_point = de_boor_algorithm(control_points, 4, knot_vector, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    % Find index of knot interval that contains t_star.
    k = find(knot_vector <= t_star);
    k = k(end);

    % Calculate multiplicity of t_star in the knot vector (0<=s<=degree+1).
    s = sum(eq(t_star, knot_vector));

    % Num. times t_star must be repeated to reach a multiplicity
    % equal to the degree.
    h = degree - s; 

    % Copy of influenced control points.
    order = degree + 1;
    P_ir = zeros(order, size(control_points, 2), h+1);
    P_ir((k-degree):(k-s), :, 1) = control_points((k-degree):(k-s), :);

    % Main De Boor algorithm.
    q = k - 1;
    if h > 0
        for r = 1:h
            for i = q-degree+r : q-s
                a_ir = (t_star - knot_vector(i+1)) / (knot_vector(i+ ...
                        degree-r+2)-knot_vector(i+1));
                P_ir(i+1, :, r+1) = (1 - a_ir)*P_ir(i, :, r) + a_ir * ...
                                    P_ir(i+1, :, r);
            end
        end
        curve_point = P_ir(k-s, :, h+1);
    elseif k == numel(knot_vector)
        curve_point = control_points(end, :);
    else
        curve_point = control_points(k-degree, :);
    end
end
