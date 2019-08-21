function[next_node] = extend_tree(cur_node, target_node)
    global step_length_3D;
    v = target_node-cur_node;
    
    next_node = cur_node+step_length_3D*v/norm(v);
    
    pointF = check_path_to_next_node(cur_node, next_node);
    if pointF <= -100
        next_node = -100;
        return;
    end
    
    next_node = [cur_node+step_length_3D*v/norm(v), pointF]; 
end