set_RRT_globals();
set_arms_lengths(5); %Arbitrary z0
get_ax_dim();
global node_it num_nodes;

way_angles = {};
way_z0 = {};

way_angles{1} = containers.Map();
way_angles{1}('C') = pi/2;
way_angles{1}('D') = 0;
way_angles{1}('E') = 0;
way_angles{1}('T') = pi/2;
way_z0{1} = 8;

way_angles{2} = containers.Map();
way_angles{2}('C') = pi/2;
way_angles{2}('D') = 0;
way_angles{2}('E') = -pi/2;
way_angles{2}('T') = pi/2;
way_z0{2} = 8;

way_angles{3} = containers.Map();
way_angles{3}('C') = pi/2;
way_angles{3}('D') = -pi/2;
way_angles{3}('E') = 0;
way_angles{3}('T') = pi/2;
way_z0{3} = 12;

way_angles{4} = containers.Map(); %TODO: Replace with angles got from IK
way_angles{4}('C') = 0.1814;
way_angles{4}('D') = -1.3771;
way_angles{4}('E') = -1.9460;
way_angles{4}('T') = pi/2;
way_z0{4} = 15;

p = 0;
num_nodes = 150;

for i = 1:3
    if i == 3
        p = 1;
    end
    
    while RRT_by_angle_func(way_angles{i}, way_z0{i}, way_angles{i+1}, way_z0{i+1}, p) ~= 1
        node_it = 1;
    end
    
    node_it = 1;
end
