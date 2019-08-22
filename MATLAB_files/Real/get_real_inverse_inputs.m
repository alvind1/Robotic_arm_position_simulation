function[x, y, z, theta_x ,theta_y, z0] = get_real_inverse_inputs()
    %[cx, cy, ~, ~, ~, holez, ~, ~, ~, ~] = get_boardhole_coords();
    x = 34.82; %Target Coordinates in inches
    y = 11.605; %If y is 0, there are multiple solutions for z0
    
    adjustment_to_b_axis = 29.75-25.745;
    z = 17.828-adjustment_to_b_axis;
    
    theta_x = 0.70*180/pi; %degrees 
    theta_y = -90; %degrees
    
    if (abs(theta_x-90) < 0.1 || abs(theta_x-270) < 0.1) && abs(y) > 0.1
        error("Y not 0 while theta_x is 0");
    end
    
    point = [x, y, z];
    
    theta_x = theta_x*pi/180;%+pi/2; %to convert to degrees and I assumed a different position when theta_x = 0;
    theta_y = theta_y*pi/180;
    
    z0 = get_z0(point, theta_x, theta_y);
    %z0 = 10;
end