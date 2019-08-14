function[] = move_specific_angle(start_angles, target, k, start_z0, z0, p, n)
    %% Constants  
    end_angles = containers.Map(start_angles.keys, start_angles.values);
    end_angles(k) = target;
    
    animate_by_angle(start_angles, end_angles, start_z0, start_z0, p, n);
    
    start_angles(k) = target;
end