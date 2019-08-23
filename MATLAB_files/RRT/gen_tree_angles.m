function[inter_coord] = gen_tree_angles(nodes, target)
    global node_it num_nodes ax;
    max_z = 10; %FIXME: Check
    splt = zeros(1, num_nodes);
    prob = 0.1;
    
    hold on;
    
    inter_coord = -100;
    while node_it < num_nodes
       ran = rand;
       
       if ran <= prob
           temp_target = target;
       else
           temp_target = [rand*2*pi-pi, rand*2*pi-pi, rand*2*pi-pi, rand*2*pi-pi, rand*max_z+1];
       end
       
       [closest_node, closest_it] = get_closest_angle_node(nodes, temp_target);
       next_node = extend_tree(closest_node(1:5), temp_target(1:5));

       if next_node == -100
           continue;
       else           
           nodes(node_it, :) = [next_node, closest_it];
           
           splt(node_it-1) = scatter3(nodes(node_it, 6), nodes(node_it, 7), nodes(node_it, 8), 'r');
           axis(ax);
           drawnow;
           disp(node_it);
           
           if (norm(nodes(node_it, 1:5)-target(1:5)) <= 0.5 && ~isscalar(check_path_to_next_node(nodes(node_it, 1:5), target(1:5)))) %FIXME: Change vicinity
               disp("FOUND");
               delete(splt);
               inter_coord = backtrack_3D(nodes);
               break;
           end
           
           node_it = node_it+1;
       end
    end
    if inter_coord == -100
        error("DID NOT FIND");
    end
end