function [new_V] = degree_elevation(V, n)
% DEGREE_ELEVATION:
%   Implementation of the degree elevation algorithm for Bézier curves.
% 
% Syntax: [new_V] = degree_elevation(V, n)
%
% Input:
%   - V: (n+1 x 2) matrix that contains the control points of the curve.
%   - n: The degree of the Bézier curve.
%
% Output:
%   - new_V: New control points with elevated degree.
%
% Example: 
%   V = [0 0; 1 2; 3 2; 6 -1];
%   new_V = degree_elevation(V, length(V)-1);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    new_V = zeros(n+2, 2);
    new_V(1, :) = V(1, :);
    new_V(end, :) = V(end, :);
    for i = 1 : n
        new_V(i+1, :) = i/(n+1)*V(i, :) + (1-i/(n+1))*V(i+1, :);
    end
end
