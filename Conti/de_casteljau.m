function [curve_point] = de_casteljau(control_points, t_star)
% DE_CASTELJAU:
%   Implementation of de Casteljau algorithm for evaluate B�zier curves.
% 
% Syntax: [curve_point] = de_casteljau(control_points, t_star)
%
% Input:
%   - control_points: (n+1 x m) matrix that contains all the control 
%                     points of the curve with m dimensions.
%   - t_star: parameter value in which i want to evaluate the curve.
%
% Output:
%   - curve_point: estimated point of the B�zier curve corresponding to 
%                  t_star.
%
% Example: 
%   control_points = [0 0; 1 2; 3 2; 6 -1];
%   curve_point = de_casteljau(control_points, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    % Checks arguments passed to the function.
    arguments
        control_points (:, :) {validateattributes(control_points, ...
                               {'numeric'}, {'finite', 'nonempty'})} 
        t_star {validateattributes(t_star, {'numeric'}, {'>=', 0, ...
                                   '<=', 1, 'finite', 'scalar'})} 
    end
    
    % Calculate the degree of the B�zier curve.
    degree = size(control_points, 1) - 1;
    
    % Main de Casteljau algorithm.
    for k = 1 : degree
        for i = 1 : degree-k+1
            control_points(i, :) = (1.0 - t_star)*control_points(i, :) ...
                                   + t_star*control_points(i+1, :);
        end
    end
    curve_point = control_points(1, :);
end
