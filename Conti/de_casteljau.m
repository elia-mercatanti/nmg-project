function [C_star] = de_casteljau(V, n, t_star)
% DE_CASTELJAU:
%   Implementation of de Casteljau algorithm for evaluate Bézier curves.
% 
% Syntax: [C_star] = de_casteljau(V, n, t_star)
%
% Input:
%   - V: (n+1 x 2) matrix that contains the control points of the curve.
%   - n: The degree of the Bézier curve.
%   - t_star: parameter in which i want to evaluate the curve.
%
% Output:
%   - C_star: Estimated point of the Bézier curve corresponding to t_star.
%
% Example: 
%   V = [0 0; 1 2; 3 2; 6 -1];
%   C_star = de_casteljau(V, length(V)-1, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    for k = 1 : n
        for i = 1 : n-k+1
            V(i, :) = (1.0 - t_star)*V(i, :) + t_star*V(i+1, :);
        end
    end
    C_star = V(1, :);
end
