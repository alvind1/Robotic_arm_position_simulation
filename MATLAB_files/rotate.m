function[rotated_points] = rotate(points, z0)
    temp = points('C');
    x0 = temp(1);
    v = values(points);
    k = keys(points);
    
    rotated_points = containers.Map();
    for i=1:length(v)
        rotated_points(k{i}) = points(k{i});
    end
    
    for i=4:length(v)
        [rotated_angles] = get_rotation_angles(points(k{i})-points('C'), z0, x0);
        rx = rotx(-rotated_angles('X'));
        ry = roty(-rotated_angles('Y'));
        rz = rotz(-rotated_angles('Z'));
        
        temp = points(k{i})-points('C');
        temp = rx*temp;
        temp = ry*temp;
        temp = rz*temp;
        rotated_points(k{i}) = temp+points('C');
    end
        
end