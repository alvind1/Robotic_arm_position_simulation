function[] = move_specific_angle(start_angles, target, k, start_z0, z0, p, n)
    %% Constants 
    grid on ;
    axis manual;
    global arms_lengths;
    
    hold on;
    
    end_angles = containers.Map(start_angles.keys, start_angles.values);
    end_angles(k) = target;
    
    for j = 1:n
        [temp_angles, temp_z0] = get_angles_naive(j, n, end_angles, start_angles, start_z0, start_z0);
        [points, ~] = FK(temp_angles, temp_z0);
        arms_lengths('AB') = temp_z0;
        
        animate_func(temp_angles, points, temp_z0, j, p, n);
    end
    
    start_angles(k) = target;
end