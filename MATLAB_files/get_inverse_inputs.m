function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    %[cx, cy, ~, ~, ~, holez, ~, ~, ~, ~] = get_boardhole_coords();
    x = 35; %Target Coordinates
    y = 0;
    z = 12;
    theta_x = pi/4; %In radians
    theta_y = -pi;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end