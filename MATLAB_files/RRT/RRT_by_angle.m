set_RRT_globals();
set_arms_lengths(5); %Arbitrary z0
get_ax_dim();
global num_nodes node_it arms_lengths;

nodes = zeros(num_nodes, 9); %3 joint angles, 1 plane rotation angle, 1 z0, 1 point F (for plotting), 1 node index

%[start_angles, start_z0] = get_starting_angles();
start_angles = containers.Map();
start_angles('C') = pi/2;
start_angles('D') = 0;
start_angles('E') = 0;
start_angles('T') = pi/2;
start_z0 = 12;

arms_lengths('AB') = [0, 0, start_z0];
[start_points, ~] = FK(start_angles, start_z0);

hold on;
animate_func(start_angles, start_points, start_z0, 1, 1, 1);

% global test_nodes; 
% test_nodes = zeros(num_nodes, 5);
% test_nodes(1, :) = [1.4383, -2, 1, 1.5394, 10];
% test_nodes(2, :) = [1.3583, -2, 0.8, 1.5394, 10];

nodes(node_it, :) = [start_angles('C'), start_angles('D'), start_angles('E'), start_angles('T'), start_z0, start_points('F'), 1];
node_it = node_it+1;


end_angles = containers.Map(); %TODO: Replace with angles got from IK
end_angles('C') = pi/2;
end_angles('D') = 0;
end_angles('E') = -pi/2;
end_angles('T') = pi/2;
end_z0 = 8;
arms_lengths('AB') = [0, 0, end_z0];
[end_points, ~] = FK(end_angles, end_z0);
%plot_points(end_points, end_angles, "FINISH");

plot_board();
inter_coord = gen_tree_angles(nodes, [end_angles('C'), end_angles('D'), end_angles('E'), end_angles('T'), end_z0, end_points('F')]);
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
% Implement KD instead of a linear search for closest node *HIGH PRIORITY
% Create another array of possible closest node for target instead of
% repeatedly checking a node that has been already checked *DIDN'T WORK
% Find optimal probability and step size
% Create a function for the step size that changes depending on how close
% the arm is to the obstacle and which angles are changing the most
% Create list of known way points to help process
% Add pointF to target pointF in checking closest distance
% Make bidirectional RRT
%TODO: Put safety net around obstacle 
%TODO: weight the angle changes when it comes to distance cost
%TODO: Find 5d sphere in which there can be a solution found in < 1000 or
%2000 nodes
%TODO: Bug -> path hits obstacle (hard to detect since it is only at a
%point and stepsize may be too big to check), need to add safety net in
%front and behind obstacle as well
%FIXME: Check why the random sampling is +y oriented

%1. Implement KD tree
%2. Bidirectional RRT or RRT-connect
