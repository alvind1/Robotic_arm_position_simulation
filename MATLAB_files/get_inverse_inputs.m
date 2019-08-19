function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    x = 32; %Target Coordinates
    y = 6;
    z = 12;
    theta_x = 0; 
    theta_y = 0;
    
    point = [x, y, z];
    z0 = get_z0(point, theta_x, theta_y);
end