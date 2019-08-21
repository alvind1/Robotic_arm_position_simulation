function[closest_node, closest_it] = get_closest_angle_node(nodes, target)
    global node_it;
    max_dist = 1000000; %May need to check
    
    n = node_it;
    
    for i = 1:n-1 %May need to switch to kd tree to optimize
        tempa = [nodes(i, 1), nodes(i, 1), nodes(i, 1), nodes(i, 2), nodes(i, 2), nodes(i, 3:5)]; %FIXME: Check weighting of angle changes
        tempb = [target(1), target(1), target(1), target(2), target(2), target(3:5)];
        if norm(tempa-tempb) < max_dist
            max_dist = norm(nodes(i, 1:5)-target);
            closest_node = nodes(i, :);
            closest_it = i;
        end
    end
    
end