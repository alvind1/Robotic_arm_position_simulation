function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    x = 9; %Target Coordinates
    y = 11;
    z = 7;
    theta_x = 0.4; 
    theta_y = -0.7;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end