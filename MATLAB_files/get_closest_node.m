function[closest_node, closest_it] = get_closest_node(nodes, target)
    global node_it;
    max_dist = 1000000; %May need to check
    
    for i = 1:node_it-1 %May need to switch to kd tree to optimize
        if norm(nodes(i, 1:5)-target) < max_dist
            max_dist = norm(nodes(i, 1:5)-target);
            closest_node = nodes(i, :);
            closest_it = i;
        end
    end
    
end