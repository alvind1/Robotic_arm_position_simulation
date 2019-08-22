function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    %[cx, cy, ~, ~, ~, holez, ~, ~, ~, ~] = get_boardhole_coords();
    x = 34; %Target Coordinates
    y = 6;
    z = 24;
    theta_x = 0.7; %In radians
    theta_y = -0.38;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end