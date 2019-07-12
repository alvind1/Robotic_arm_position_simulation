function [c]  = cosine_law_side(a, b, angle_C)
    c = sqrt(a^2+b^2-2*a*b*cos(angle_C));
end 