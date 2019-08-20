function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    x = 32; %Target Coordinates
    y = 3;
    z = 12;
    theta_x = 0; 
    theta_y = -0.4;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end