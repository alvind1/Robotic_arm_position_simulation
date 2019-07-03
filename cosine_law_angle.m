function [angle] = cosine_law_angle(a, b, c)
   angle = acos((a^2+b^2-c^2)/(2*a*b));
end 