%% Constants
grid on;
axis manual;

xmin = 0;
xmax = 19;
ymin = -10;
ymax = 20;
zmin = 0;
zmax = 15;
ax = ([xmin, xmax, ymin, ymax, zmin, zmax]);

stage_angles = {};
stage_points = {};
target_points = {};
target_theta_x = {};
target_theta_y = {};

[cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords();
[x, y, z, theta_x, theta_y, z0] = get_inverse_inputs();
arms_lengths = get_arms_lengths(z0);

[angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1, arms_lengths);
if angles <= -100 && points <= -100
    error("TARGET ERROR");
end

target_points{1} = [arms_lengths('BC'), 15, 5]; %Starting Position
target_theta_x{1} = 0;
target_theta_y{1} = -pi/2;
start_z0 = target_points{1}(3)-target_points{1}(2)*tan(target_theta_x{1});


%% Algo
[stage_angles{1}, stage_points{1}]  = IK(target_points{1}(1), target_points{1}(2), target_points{1}(3), target_theta_x{1}, target_theta_y{1}, start_z0, 1, arms_lengths); %FIXME: z0 is off

[target_points{2}, target_theta_x{2}, target_theta_y{2}] = get_s1_points(board_theta, ppoint); %FIXME
[stage_angles{2}, stage_points{2}] = IK(target_points{2}(1), target_points{2}(2), target_points{2}(3), target_theta_x{2}, target_theta_y{2}, z0, 1, arms_lengths);

if(stage_angles{2} <= -100 && stage_points{2} <= -100)
    error("S1");
end

f_animate(stage_angles{1}, stage_angles{2}, start_z0, z0, ax, arms_lengths, 0, 100);

[target_points{3}, target_theta_x{3}, target_theta_y{3}] = get_s2_points(board_theta, ppoint);
[stage_angles{3}, stage_points{3}] = IK(target_points{3}(1), target_points{3}(2), target_points{3}(3), target_theta_x{3}, target_theta_y{3}, z0, 1, arms_lengths);
 
f_animate(stage_angles{2}, stage_angles{3}, z0, z0, ax, arms_lengths, 0, 100);
f_animate(stage_angles{3}, angles, z0, z0, ax, arms_lengths, 1, 100);