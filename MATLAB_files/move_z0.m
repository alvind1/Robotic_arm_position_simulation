function[] = move_z0(points, z0, new_z0, angles, p, n)
    %% Constants 
    grid on ;
    axis manual;
    global arms_lengths;
    
    hold on;
    
    dist = new_z0-z0;
    
    k = keys(points);
    val = values(points);
    
    for j = 1:n
        for i = 2:length(points)
            points(k{i}) = [val{i}(1), val{i}(2), val{i}(3)+dist*j/n];
        end
        
        arms_lengths('AB') = z0 + dist*j/n;
        
        animate_func(angles, points, arms_lengths('AB'), j, p, n);
    end
    
end