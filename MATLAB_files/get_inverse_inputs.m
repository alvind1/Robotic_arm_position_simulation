function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    %[cx, cy, ~, ~, ~, holez, ~, ~, ~, ~] = get_board_coords();
    x = 10+0.4; %Target Coordinates
    y = 0;
    z = 11.5;
    theta_x = pi/2; %In radians
    theta_y = pi;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end