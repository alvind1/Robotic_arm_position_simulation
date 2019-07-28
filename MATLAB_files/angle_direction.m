function[sign] = angle_direction(a, b, theta_y)
    temp_cross = cross(a, b);
    sign = 1;
    if temp_cross == 0
        disp("B");
        sign = 0;
    elseif 0 < theta_y < pi
        disp("C");
        disp(temp_cross);
        if temp_cross(2) < 0
            sign = -1;
        else
            sign = 1;
        end
        disp(sign);
    elseif pi < theta_y < 2*pi
        disp("D");
        if temp_cross(2) > 0
            sign = -1;
        else 
            sign = 1;
        end
    elseif theta_y == 0
        if temp_cross(3) > 0
            sign = -1;
        else 
            sign = 1;
        end
    elseif theta_y == pi
        if temp_cross(3) < 0
            sign = -1;
        else 
            sign = 1;
        end
    end
end