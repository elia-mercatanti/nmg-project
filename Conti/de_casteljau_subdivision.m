function [cp_first_curve, cp_second_curve] = ...
                          de_casteljau_subdivision(control_points, t_star)
% DE_CASTELJAU_SUBDIVISION:
%   Implementation of de Casteljau based subdivision algorithm for Bézier
%   curves.
% 
% Syntax: [cp_first_curve, cp_second_curve] = ...
%                          de_casteljau_subdivision(control_points, t_star)
%
% Input:
%   - control_points: (n+1 x m) matrix that contains all the control 
%                     points of the curve with m dimensions.
%   - t_star: parameter in which i want to divide the original curve.
%
% Output:
%   - cp_first_curve: control points of the first curve.
%   - cp_second_curve: control points of the second curve.
%
% Example:
%   control_points = [0 0; 1 2; 3 2; 6 -1];
%   [cp_first_curve, cp_second_curve] = ...
%                           de_casteljau_subdivision(control_points, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it
    
    % Checks arguments passed to the function.
    arguments
        control_points (:, :) {validateattributes(control_points, ...
                               {'numeric'}, {'finite', 'nonempty'})} 
        t_star {validateattributes(t_star, {'numeric'}, {'>=', 0, ...
                                   '<=', 1, 'finite', 'scalar'})} 
    end
    
    % Calculate the degree of the Bézier curve.
    degree = size(control_points, 1) - 1;
    
    % Initialization of the control points for the two curves.
    cp_first_curve = zeros(degree+1, size(control_points, 2));
    cp_second_curve = cp_first_curve;
    cp_first_curve(1, :) = control_points(1, :);
    cp_second_curve(end, :) = control_points(end, :);
    
    % Main de Casteljau based subdivision algorithm.
    for k = 1 : degree
        for i = 1 : degree-k+1
            control_points(i, :) = (1.0-t_star)*control_points(i, :) + ...
                                   t_star*control_points(i+1, :);
        end
        cp_first_curve(k+1, :) = control_points(1, :);
        cp_second_curve(end-k, :) = control_points(degree-k+1, :);
    end
end
