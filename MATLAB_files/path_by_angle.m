%% Constants
grid on;
axis manual;

stage_angles = {};
stage_points = {};
target_points = {};
target_theta_x = {};
target_theta_y = {};

[cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords();
plot_board();
[x, y, z, theta_x, theta_y, z0] = get_inverse_inputs();
set_arms_lengths(z0);
get_ax_dim();
global arms_lengths;

[angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1);
if angles <= -100 && points <= -100
    error("TARGET ERROR");
end

target_points{1} = [10, 11, 11]; %Starting Position
target_theta_x{1} = 0;
target_theta_y{1} = -pi/2;
start_z0 = get_z0(target_points{1}, target_theta_x{1}, target_theta_y{1});
arms_lenghts('AB') = start_z0;

%% Algo
[stage_angles{1}, stage_points{1}]  = IK(target_points{1}(1), target_points{1}(2), target_points{1}(3), target_theta_x{1}, target_theta_y{1}, start_z0, 1); %FIXME: z0 is off

[stage_angles{1}, stage_points{1}] = move_specific_angle(stage_angles{1}, stage_points{1}, 3, 'C', start_z0, start_z0, 0, 10);
[stage_angles{1}, stage_points{1}] = move_specific_angle(stage_angles{1}, stage_points{1}, -pi/2, 'D', start_z0, start_z0, 0, 10);
[stage_angles{1}, stage_points{1}] = move_specific_angle(stage_angles{1}, stage_points{1}, pi/2, 'E', start_z0, start_z0, 0, 10);
[stage_angles{1}, stage_points{1}] = move_specific_angle(stage_angles{1}, stage_points{1}, pi/2, 'T', start_z0, start_z0, 0, 10);
[stage_points{1}, start_z0] = move_z0(stage_points{1}, start_z0, holez-arms_lengths('CD'), stage_angles{1}, 0, 20);

[stage_angles{1}, stage_points{1}] = move_specific_angle(stage_angles{1}, stage_points{1}, -pi/2, 'E', start_z0, start_z0, 0, 10);
ang = ['C', 'D', 'E'];
to = [0, 0, 0];
[stage_angles{1}, stage_points{1}] = move_specific_angle(stage_angles{1}, stage_points{1}, to, ang, start_z0, holez, 1, 50);

% [target_points{2}, target_theta_x{2}, target_theta_y{2}] = get_s1_points(board_theta, ppoint); %FIXME
% [stage_angles{2}, stage_points{2}] = IK(target_points{2}(1), target_points{2}(2), target_points{2}(3), target_theta_x{2}, target_theta_y{2}, z0, 1);
% 
% if(stage_angles{2} <= -100 && stage_points{2} <= -100)
%     error("S1");
% end
% 
% animate_by_angle(stage_angles{1}, stage_angles{2}, start_z0, z0, 0, 50);
% 
% [target_points{3}, target_theta_x{3}, target_theta_y{3}] = get_s2_points(board_theta, ppoint);
% [stage_angles{3}, stage_points{3}] = IK(target_points{3}(1), target_points{3}(2), target_points{3}(3), target_theta_x{3}, target_theta_y{3}, z0, 1);
%  
% animate_by_angle(stage_angles{2}, stage_angles{3}, z0, z0, 0, 50);
% animate_by_angle(stage_angles{3}, angles, z0, z0, 1, 50);