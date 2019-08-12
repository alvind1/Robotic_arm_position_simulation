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

[cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords();

[x, y, z, theta_x, theta_y, z0] = get_inverse_inputs();

get_arms_lengths(z0);

[angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1, arms_lengths);
if angles <= -100 && points <= -100
    error("TARGET ERROR");
end

start_x = arms_lengths('BC'); %Starting Position
start_y = 15;
start_z = 5; 
start_theta_x = 0;
start_theta_y = -pi/2;
start_z0 = start_z-start_y*tan(start_theta_x);

stage_angles = {};
stage_points = {};
target_points = {};
target_theta_x = {};
target_theta_y = {};


%% Algo
[stage_angles{1}, stage_points{1}]  = IK(start_x, start_y, start_z, start_theta_x, start_theta_y, start_z0, 1, arms_lengths); %FIXME: z0 is off

[target_points{1}, target_theta_x{1}, target_theta_y{1}] = get_s1_points(board_theta, ppoint);
[stage_angles{2}, stage_points{2}] = IK(target_points{1}(1), target_points{1}(2), target_points{1}(3), target_theta_x{1}, target_theta_y{1}, z0, 1, arms_lengths);

if(stage_angles{2} <= -100 && stage_points{2} <= -100)
    error("S1");
end

f_animate(stage_angles{1}, stage_angles{2}, start_z0, z0, ax, arms_lengths, 1, 100);

% xs2 = cx;
% ys2 = cy;
% zs2 = cz;
% theta_xs2 = 0;
% theta_ys2 = pi/4;
% z0s2 = zs2-ys2*tan(theta_xs2);
% [s2_angles, s2_points] = IK(xs2, ys2, zs2, theta_xs2, theta_ys2, z0s2, 1, arms_lengths);
% 
% f_animate(s1_angles, s2_angles, z0s1, z0s2, ax, arms_lengths, 0, round(norm(s1_points('F')-s2_points('F')))*10);
% f_animate(s2_angles, angles, z0s2, z0, ax, arms_lengths, 1, round(norm(s2_points('F')-points('F')))*10);