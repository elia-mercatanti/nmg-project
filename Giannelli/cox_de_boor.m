function [y] = cox_de_boor(i, r, t, t_star, k)
    if r == 1
        % Check even the last interval special case.
        if (t_star >= t(i) && t_star < t(i+1)) || ((t_star >= t(i) && ...
            t_star <= t(i+1) && t_star == t(end) && i == length(t)-k)) 
            y = 1;
        else
            y = 0;
        end
    else
        y = omega(i, r, t_star, t)*cox_de_boor(i, r-1, t, t_star, k) + ...
            (1 - omega(i+1, r, t_star, t)) * ...
            cox_de_boor(i+1, r-1, t, t_star, k);
    end
end

function [omega_ir] = omega(i, r, t_star, t)
    if t(i) == t(i+r-1)
        omega_ir = 0;
    elseif t_star <= t(i+r-1)
        omega_ir = (t_star-t(i)) / (t(i+r-1)-t(i));
    else
        omega_ir = 0;
    end
end
