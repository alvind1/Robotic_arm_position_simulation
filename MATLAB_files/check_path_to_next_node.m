function[pointF] = check_path_to_next_node(cur_node, next_node)
    global arms_lengths;
    n = ceil(norm(next_node-cur_node)/0.1);
    v = next_node-cur_node;
    
    temp_angles = containers.Map();
    
    for i=1:n
       temp_node = cur_node+i*v/n;
       temp_angles('C') = temp_node(1);
       temp_angles('D') = temp_node(2);
       temp_angles('E') = temp_node(3);
       temp_angles('T') = temp_node(4);
       temp_z0 = temp_node(5);
       arms_lengths('AB') = temp_node(5);
       
       [points, ~] = FK(temp_angles, temp_z0);
       if points <= -100
           pointF = -100;
           return;
       end
    end
    pointF = points('F');
end