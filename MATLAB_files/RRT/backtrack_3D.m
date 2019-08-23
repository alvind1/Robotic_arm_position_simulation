function[inter_coord] = backtrack_3D(nodes)
    global node_it;
    
    cur_it = node_it;
    vertices = zeros(node_it, 8);
    
    c = 1;
    while(cur_it ~= 1)
        vertices(c, :) = nodes(cur_it, 1:8);
        c = c+1;
        
        scatter3(nodes(cur_it, 6), nodes(cur_it, 7), nodes(cur_it, 8), 'b');
        cur_it = nodes(cur_it, 9);
    end
    
    vertices(c, :) = nodes(1, 1:8);
    
    inter_coord = flipud(vertices(1:c, :));
    
%     for i = 1:c
%         temp_angles = containers.Map();
%         temp_angles('C') = inter_coord(i, 1);
%         temp_angles('D') = inter_coord(i, 2);
%         temp_angles('E') = inter_coord(i, 3);
%         temp_angles('T') = inter_coord(i, 4);
%         temp_z0 = inter_coord(i, 5);
%         [points, ~] = FK(temp_angles, temp_z0);
%         animate_func(temp_angles, points, temp_z0, i, 0, c);
%     end
end