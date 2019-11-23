function [y] = cox_de_boor(i, r, order, knot_vector, t_star)
% COX_DE_BOOR:
%   Implementation of Cox-de Boor recursion formula for evaluating 
%   B-Spline basis, return the evaluation of i-th element of the B-Spline 
%   base of a given order and a knot vector in a t_star parameter value.
% 
% Syntax: [y] = cox_de_boor(i, r, order, knot_vector, t_star)
%
% Input:
%   - i: i-th element of the B-Spline base.
%   - r: recursive order of the B-Spline base (used in recursion formula).
%   - order: real order of the B-Spline base.
%   - knot_vector: knot vector of the B-Spline curve.
%   - t_star: parameter value in which i want to evaluate the base element.
%
% Output:
%   - y: estimated value of the i-th element of the base corresponding to 
%        t_star.
%
% Example: 
%   knot_vector = [0 0 0 1 1 1];
%   y = cox_de_boor(1, 4, 4, knot_vector, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it
    
    % Check if we have arrived at the base case 
    if r == 1
        % Check if t_star is included in the proper interval or in the last
        % interval special case.
        if (t_star >= knot_vector(i) && t_star < knot_vector(i+1)) || ...
           ((t_star >= knot_vector(i) && t_star <= knot_vector(i+1) && ...
           t_star == knot_vector(end) && i == length(knot_vector)-order)) 
            y = 1;
        else
            y = 0;
        end
    else
        % Main Cox-de Boor recursion formula.
        y = omega(i, r, knot_vector, t_star)*cox_de_boor(i, r-1, ...
            order, knot_vector, t_star) + (1 - omega(i+1, r, ...
            knot_vector, t_star)) * cox_de_boor(i+1, r-1, order, ...
            knot_vector, t_star);
    end
end

function [omega_ir] = omega(i, r, knot_vector, t_star)
% OMEGA:
%   Calculate the coefficients omega_ir in the Cox-de Boor recursion 
%   formula.
% 
% Syntax: [omega_ir] = omega(i, r, knot_vector, t_star)
%
% Input:
%   - i: i-th element of the B-Spline base.
%   - r: recursive order of the B-Spline base (used in recursion formula).
%   - knot_vector: knot vector of the B-Spline curve.
%   - t_star: parameter value in which i want to evaluate the base element.
%
% Output:
%   - omega_ir: returned value of coefficients omega_ir.
%
% Example: 
%   knot_vector = [0 0 0 1 1 1];
%   omega_ir = omega(1, 2, knot_vector, 0.5);

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

    % Main calculations for the coefficient and denominator check (~= 0).
    if t_star <= knot_vector(i+r-1) && knot_vector(i+r-1) ~= knot_vector(i)
        omega_ir = (t_star-knot_vector(i)) / (knot_vector(i+r-1) - ...
                   knot_vector(i));
    else
        omega_ir = 0;
    end
end
