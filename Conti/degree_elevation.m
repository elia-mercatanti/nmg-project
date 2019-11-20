function [new_control_points] = degree_elevation(control_points)
% DEGREE_ELEVATION:
%   Implementation of the degree elevation algorithm for Bézier curves.
% 
% Syntax: [new_control_points] = degree_elevation(control_points)
%
% Input:
%   - control_points: (n+1 x m) matrix that contains all the control 
%                     points of the curve with m dimensions.
%
% Output:
%   - new_control_points: new control points with elevated degree.
%
% Example: 
%   control_points = [0 0; 1 2; 3 2; 6 -1];
%   new_control_points = degree_elevation(control_points);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    arguments
        control_points (:, :) {validateattributes(control_points, ...
                               {'numeric'}, {'finite', 'nonempty'})}
    end
    
    degree = size(control_points, 1) - 1;
    
    new_control_points = zeros(degree+2, size(control_points, 2));
    new_control_points(1, :) = control_points(1, :);
    new_control_points(end, :) = control_points(end, :);
    
    for i = 1 : degree
        new_control_points(i+1, :) = i/(degree+1)*control_points(i, :) ...
                                + (1-i/(degree+1))*control_points(i+1, :);
    end
end
