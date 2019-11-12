function [C1, C2] = de_casteljau_subdivision(V, n, t_star)
% DE_CASTELJAU_SUBDIVISION:
%   Implementation of de Casteljau based subdivision algorithm for Bézier
%   curves.
% 
% Syntax: [C1, C2] = de_casteljau_subdivision(V, n, t_star)
%
% Input:
%   - V: (n+1 x 2) matrix that contains the control points of the curve.
%   - n: The degree of the Bézier curve.
%   - t_star: parameter in which i want to divide the original curve.
%
% Output:
%   - C1: Control points of the first curve.
%   - C2: Control points of the second curve.
%
% Example:
%   V = [0 0; 1 2; 3 2; 6 -1];
%   [C1, C2] = de_casteljau_subdivision(V, length(V)-1, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    C1 = zeros(n+1, 2);
    C2 = zeros(n+1, 2);
    C1(1, :) = V(1, :);
    C2(end, :) = V(end, :);
    for k = 1 : n
        for i = 1 : n-k+1
            V(i, :) = (1.0-t_star)*V(i, :) + t_star*V(i+1, :);
        end
        C1(k+1, :) = V(1, :);
        C2(end-k, :) = V(n-k+1, :);
    end
end
