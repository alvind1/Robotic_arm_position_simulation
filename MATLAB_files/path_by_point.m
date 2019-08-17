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
if(points <= -100 && angles <= -100)
    error("TARGET");
    if(points == -100 && angles == -100)
        error("LENGTH");
    elseif(points == -200 && angles == -200)
        error("TRIANGLE_INEQUALITY");
    elseif(points == -300 && angles == -300)
        error("OVERLAP SEGMENTS");
    elseif(points == -400 && angles == -400)
        error("NEGATIVE");
    elseif(points == -500 && angles == -500)
        error("BOARD INTERSECTION");
    end
end

target_points{1} = [arms_lengths('BC'), 15, 5]; %Starting Position
target_theta_x{1} = 0;
target_theta_y{1} = -pi/2;
start_z0 = target_points{1}(3)-target_points{1}(2)*tan(target_theta_x{1});
arms_lengths('AB') = start_z0;

%% Algo

start_point = [10, 11, 11];
start_theta_x = 0;
start_theta_y = -0.4; 

end_point = [cx-2, cy, holez];
end_theta_x = 0;
end_theta_y = 0.4;
follow_line(start_point, start_theta_x, start_theta_y, end_point, end_theta_x, end_theta_y, 0, 10); %Slow

start_point = end_point;
start_theta_x = end_theta_x;
start_theta_y = end_theta_y;
end_point = [cx+2, cy, holez];
end_theta_x = 0;
end_theta_y = 0.4;
follow_line(start_point, start_theta_x, start_theta_y, end_point, end_theta_x, end_theta_y, 1, 10); %Slow
