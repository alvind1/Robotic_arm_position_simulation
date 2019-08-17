function[temp_angles, temp_z0] = get_angles_naive(j, n, angles, initial_angles, start_z0, z0)
    temp_angles = containers.Map();
    k = keys(angles);
    v1 = values(angles);
    v2 = values(initial_angles);
    
    for i=1:length(angles)
        temp_angles(k{i}) = j*(v1{i}-v2{i})/n + v2{i};
    end
    
    temp_z0 = j*(z0-start_z0)/n+start_z0;
end 