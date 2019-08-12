function[x, y, z, theta_x ,theta_y, z0] = get_inverse_inputs()
    x = 14; %Target Coordinates
    y = 0;
    z = 11;
    theta_x = 0.3; 
    theta_y = 0.2;
    
    if mod(theta_x, pi/2) > 0.01
        z1 = y*tan(theta_x);
    else
        z1 = 0; %Arbitrary value since many possible solutions
    end
    z0 = z-z1;
end