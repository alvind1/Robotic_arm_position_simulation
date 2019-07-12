function[temp_angles] = get_angles(j, n, angles)
    temp_angles = containers.Map();
    k = keys(angles);
    v = values(angles);
    
    for i=1:length(angles)
        temp_angles(k{i}) = j*v{i}/n;
    end
end 