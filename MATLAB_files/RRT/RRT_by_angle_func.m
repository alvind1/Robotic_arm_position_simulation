function[] = RRT_by_angle_func(start_angles, start_z0, end_angles, end_z0, p)
    global num_nodes node_it arms_lengths;

    nodes = zeros(num_nodes, 9); %3 joint angles, 1 plane rotation angle, 1 z0, 1 point F (for plotting), 1 node index

    arms_lengths('AB') = [0, 0, start_z0];
    [start_points, ~] = FK(start_angles, start_z0);

    hold on;
    animate_func(start_angles, start_points, start_z0, 1, 1, 1);

    nodes(node_it, :) = [start_angles('C'), start_angles('D'), start_angles('E'), start_angles('T'), start_z0, start_points('F'), 1];
    node_it = node_it+1;

    arms_lengths('AB') = [0, 0, end_z0];
    [end_points, ~] = FK(end_angles, end_z0);
    %plot_points(end_points, end_angles, "FINISH");

    plot_board();
    inter_coord = gen_tree_angles(nodes, [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0, end_points('F')]);
    inter_coord(end+1, :) = [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0, end_points('F')];

    [m, n] = size(inter_coord);
    
    q = 0;
    for i= 1:m-1
        if p == 1 && i == m-1
            q = 1;
        end
        animate_rrt(inter_coord(i, :), inter_coord(i+1, :), q);
    end
end
