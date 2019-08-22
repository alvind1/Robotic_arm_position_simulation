function[sign] = angle_direction(points, z0, num)
    val = values(points);
    k = keys(points);
    sign = containers.Map();
    
    rotated_points = containers.Map();
    rotated_points('C') = points('C');
    
    c = points('C');
    x0 = c(1);
    
    for i=4:length(points)
        coord = val{i};
        r = norm(val{i}-points('C'));
        z = sqrt(r^2-(coord(1)-x0)^2);
        if coord(2) < 0
            z = -z+z0;
        else
            z = z+z0;
        end
        rotated_points(k{i}) = [coord(1), 0, z];
    end
     
    if num == 1
        temp = rotated_points('D');
        if temp(3) < z0
            sign('C') = -1;
        elseif temp(3) > z0
            sign('C') = 1;
        else
            sign('C') = 0;
        end

        cross1 = cross(rotated_points('E')-rotated_points('C'), rotated_points('D')-rotated_points('C'));

        if cross1(2)==0
            sign('D') = 0;
        elseif cross1(2) < 0
            sign('D') = -1;
        elseif cross1(2) > 0
            sign('D') = 1;
        end

        cross1 = cross(rotated_points('F')-rotated_points('D'), rotated_points('E')-rotated_points('D'));
        if cross1(2)==0
            sign('E') = 0;
        elseif cross1(2) < 0
            sign('E') = -1;
        elseif cross1(2) > 0
            sign('E') = 1;
        end
    else
        temp = rotated_points('E')-rotated_points('F');
        if temp(1) <= 0 && temp(3) >= 0
            sign = 1;
        elseif temp(1) <= 0 && temp(3) <= 0
            sign = 4;
        elseif temp(1) >= 0 && temp(3) <= 0
            sign = 3;
        elseif temp(1) >- 0 && temp(3) >= 0
            sign = 2;
        end
    end
        
end