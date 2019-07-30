function[sign] = angle_direction(points, z0)
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
        rotated_points(k{i}) = [coord(1), 0, sqrt(r^2-(coord(1)-x0)^2)+z0];
        if coord(2) < 0
            rotated_points(k{i}) = -rotated_points(k{i});
        end
    end
      
    temp = rotated_points('D');
    if temp(3) < 0
        sign('C') = -1;
    elseif temp(3) > 0
        sign('C') = 1;
    else
        sign('C') = 0;
    end
    
    cross1 = cross(points('E')-points('C'), points('D')-points('C'));
    if cross1(2)==0
        sign('D') = 0;
    elseif cross1(2) < 0
        sign('D') = -1;
    elseif cross1(2) > 0
        sign('D') = 1;
    end
    
    cross1 = cross(points('F')-points('D'), points('E')-points('D'));
    if cross1(2)==0
        sign('E') = 0;
    elseif cross1(2) < 0
        sign('E') = -1;
    elseif cross1(2) > 0
        sign('E') = 1;
    end
end