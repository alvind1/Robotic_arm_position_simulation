set_RRT_globals();
set_arms_lengths(5); %Arbitrary z0
get_ax_dim();
global num_nodes node_it arms_lengths;

nodes = zeros(num_nodes, 9); %3 joint angles, 1 plane rotation angle, 1 z0, 1 point F (for plotting), 1 node index
closest_to_target_nodes = zeros(num_nodes, 6); %3 joint angles, 1 angleT, 1 z0, idx of node in nodes

start_angles = containers.Map();
start_angles('C') = pi/2;
start_angles('D') = 0;
start_angles('E') = 0;
start_angles('T') = pi/2;
start_z0 = 5;
arms_lengths('AB') = [0, 0, start_z0];
[start_points, ~] = FK(start_angles, start_z0);

hold on;
animate_func(start_angles, start_points, start_z0, 1, 0, 1);

nodes(node_it, :) = [start_angles('C'), start_angles('D'), start_angles('E'), start_angles('T'), start_z0, start_points('F'), 1];
node_it = node_it+1;

end_angles = containers.Map(); %TODO: Replace with angles got from IK
end_angles('C') = 2.5;
end_angles('D') = -1.8;
end_angles('E') = -1.9;
end_angles('T') = pi/2;
end_z0 = 5;
arms_lengths('AB') = [0, 0, end_z0];
[end_points, ~] = FK(end_angles, end_z0);
%plot_points(end_points, end_angles, "FINISH");

plot_board();
inter_coord = gen_tree_angles(nodes, [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0]);
inter_coord(end+1, :) = [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0, end_points('F')];

p = 0;
[m, n] = size(inter_coord);
for i= 1:m-1
    if i == m-1
        p = 1;
    end
    
    animate_rrt(inter_coord(i, :), inter_coord(i+1, :), p);
end

%% OPTIMIZING Solution Possibilities
% Implement KD instead of a linear search for closest node 
% Create another array of possible closest node for target instead of
% repeatedly checking a node that has been already checked
% Find optimal probability and step size
% Create a function for the step size that changes depending on how close
% the arm is to the obstacle and which angles are changing the most
% Create list of known way points to help process
% Add pointF to target pointF in checking closest distance
%Make bidirectional RRT
%TODO: Put safety net around obstacle 
%TODO: weight the distances
%TODO: Find 5d sphere in which there can be a solution found in < 1000 or
%2000 nodes
