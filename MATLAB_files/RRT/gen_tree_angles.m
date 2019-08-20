function[inter_coord] = gen_tree_angles(nodes, closest_to_target_nodes, target)
    global node_it num_nodes ax closest_to_target_node_it;
    max_z = 10; %FIXME: Check
    splt = zeros(1, num_nodes);
    prob = 0.3;
    
    hold on;
    
    inter_coord = -100;
    while node_it < num_nodes
       ran = rand;
       
       if ran <= prob && closest_to_target_node_it > 1
           disp("1");
           temp_target = target;
           [closest_node, closest_it] = get_closest_node(closest_to_target_nodes, temp_target, 1);
       else
           disp("2");
           temp_target = [rand*2*pi-pi, rand*2*pi-pi, rand*2*pi-pi, rand*2*pi-pi, rand*max_z+1];
           [closest_node, closest_it] = get_closest_node(nodes, temp_target, 2);
       end
       
        next_node = extend_tree(closest_node(1:5), temp_target);
        
       if next_node == -100
           if ran <= prob
               txt = {'-', closest_to_target_nodes(closest_it, 1), closest_to_target_nodes(closest_it, 2), closest_to_target_nodes(closest_it, 3), closest_to_target_nodes(closest_it, 4), closest_to_target_nodes(closest_it, 5), closest_to_target_nodes(closest_it, 6)};
               disp(txt);
               closest_to_target_nodes(closest_it, :) = [];
               closest_to_target_node_it = closest_to_target_node_it - 1;
           end
           
           continue;
       else
           if ran <= prob
%                txt = {'+', closest_to_target_nodes(closest_it, 1), closest_to_target_nodes(closest_it, 2), closest_to_target_nodes(closest_it, 3), closest_to_target_nodes(closest_it, 4), closest_to_target_nodes(closest_it, 5), closest_to_target_nodes(closest_it, 6)};
%                disp(txt);         
%                disp(node_it);
%                 txt = {'+', closest_node(1), closest_node(2), closest_node(3), closest_node(4), closest_node(5), closest_node(6)};
%                 disp(txt);
%                 txt = {'+', next_node(1), next_node(2), next_node(3), next_node(4), next_node(5), closest_node(6)};
%                 disp(txt);
               nodes(node_it, :) = [next_node, closest_node(6)];
           else  
                nodes(node_it, :) = [next_node, closest_it];
           end
           
%            txt = [nodes(node_it, 1), nodes(node_it, 2), nodes(node_it, 3), nodes(node_it, 4), nodes(node_it, 5), nodes(node_it, 9)];
%            disp(txt);
           
           closest_to_target_nodes(closest_to_target_node_it, :) = [nodes(node_it, 1:5), node_it];
           
           splt(node_it-1) = scatter3(nodes(node_it, 6), nodes(node_it, 7), nodes(node_it, 8), 'r');
           axis(ax);
           drawnow;
           %disp(node_it);
           
           if (norm(nodes(node_it, 1:5)-target) <= 0.6 && isa(check_path_to_next_node(nodes(node_it, 1:5), target), 'containers.Map')) %FIXME: Change vicinity
               disp("FOUND");
               delete(splt);
               inter_coord = backtrack_3D(nodes);
               break;
           end
           
           node_it = node_it+1;
           closest_to_target_node_it = closest_to_target_node_it+1;
       end
    end
    if inter_coord == -100
        error("DID NOT FIND");
    end
end