function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    %[cx, cy, ~, ~, ~, holez, ~, ~, ~, ~] = get_boardhole_coords();
    x = 13; %Target Coordinates
    y = 0;
    z = 15;
    theta_x = pi/2; %In radians
    theta_y = -pi/2;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end