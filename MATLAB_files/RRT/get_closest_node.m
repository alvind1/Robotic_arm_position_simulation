function[closest_node, closest_it] = get_closest_node(nodes, target, p)
    global node_it closest_to_target_node_it;
    max_dist = 1000000; %May need to check
    
    if p == 1
        n = closest_to_target_node_it;
    else
        n = node_it;
    end
    
    for i = 1:n-1 %May need to switch to kd tree to optimize
        if norm(nodes(i, 1:5)-target) < max_dist
            max_dist = norm(nodes(i, 1:5)-target);
            closest_node = nodes(i, :);
            closest_it = i;
        end
    end
    
end