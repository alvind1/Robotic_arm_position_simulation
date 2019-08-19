set_RRT_globals();
set_arms_lengths(5); %Arbitrary z0
get_ax_dim();
global num_nodes node_it arms_lengths;

nodes = zeros(num_nodes, 9); %3 joint angles, 1 plane rotation angle, 1 z0, 1 point F (for plotting), 1 node index

start_angles = containers.Map();
start_angles('C') = 0.5;
start_angles('D') = -0.3;
start_angles('E') = 0.7;
start_angles('T') = 0.3;
start_z0 = 5;
arms_lengths('AB') = [0, 0, start_z0];
[start_points, ~] = FK(start_angles, start_z0);
plot_points(start_points, start_angles, "START");
nodes(node_it, :) = [start_angles('C'), start_angles('D'), start_angles('E'), start_angles('T'), start_z0, start_points('F'), 1];
node_it = node_it+1;

end_angles = containers.Map(); %TODO: Replace with angles got from IK
end_angles('C') = -1.1;
end_angles('D') = 0.8;
end_angles('E') = 0.2;
end_angles('T') = 0.9;
end_z0 = 8;
arms_lengths('AB') = [0, 0, end_z0];
[end_points, ~] = FK(end_angles, end_z0);
%plot_points(end_points, end_angles, "FINISH");

plot_board();
inter_coord = gen_tree_angles(nodes, [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0]);
inter_coord(end+1, :) = [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0, end_points('F')];

p = 0;
for i= 1:length(inter_coord)-1
    if i == length(inter_coord)-1
        p = 1;
    end
    animate_rrt(inter_coord(i, :), inter_coord(i+1, :), p);
end
