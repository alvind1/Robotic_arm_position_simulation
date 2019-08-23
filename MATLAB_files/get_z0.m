function[z0] = get_z0(point, theta_x, theta_y)
    global arms_lengths;
    if abs(theta_x-pi/2) > 0.1 && abs(theta_x-3*pi/2) > 0.1 
        %when theta_x is not around 90 or 180 and y is around 0, there are
        %multiple solutions but when z0 = z, there should still be a
        %solution
        z1 = point(2)*tan(theta_x);
        z0 = point(3)-z1;
    else %When theta_x is around 90 or 180, y is around 0, there are multiple solutions and so we also need to specify z0 or z1
        z0 = 8; 
        %error("Specify z0 or z1");
    end
end