function[x, y, z, theta_x ,theta_y, z0] = get_real_inverse_inputs()
    %[cx, cy, ~, ~, ~, holez, ~, ~, ~, ~] = get_boardhole_coords();
    x = 35; %Target Coordinates
    y = 0;
    z = 12;
    theta_x = 45; %degrees 
    theta_y = -pi; 
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
    
    theta_x = theta_x*pi/180+pi/2; %to convert to degrees and I assumed a different position when theta_x = 0;
end