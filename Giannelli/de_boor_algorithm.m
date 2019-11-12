function [curve_point] = de_boor_algorithm(t, t_star, degree, control_points)

% Find index of knot interval that contains t_star.
k = find(t <= t_star);
k = k(end);

% Calculate the multiplicity of pg t_star in t (0 <= s <= degree+1).
s = sum(eq(t_star, t));

% Num. times t_star must be repeated to reach a multiplicity
% equal to the degree
h = degree - s; 

% Copy of influenced control points.
P_ir = zeros(degree+1, 2, degree+1);
P_ir((k-degree):(k-s), :, 1) = control_points((k-degree):(k-s), :);

% Main De Boor algorithm.
q = k - 1;
if h > 0
    for r = 1:h
        for i = q-degree+r : q-s
            a_ir = (t_star - t(i+1)) / (t(i+degree-r+2)-t(i+1));
            P_ir(i+1, :, r+1) = (1 - a_ir)*P_ir(i, :, r) + a_ir * ...
                                P_ir(i+1, :, r);
        end
    end
    curve_point = P_ir(k-s, :, h+1);
elseif k == numel(t)
    curve_point = control_points(end, :);
else
    curve_point = control_points(k-degree, :);
end