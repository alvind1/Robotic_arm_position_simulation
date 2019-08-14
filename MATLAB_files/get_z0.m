function[z0] = get_z0(point, theta_x, theta_y)
    if mod(theta_x, pi/2) > 0.01
        z1 = point(2)*tan(theta_x);
    else
        z1 = 0; %Arbitrary value since many possible solutions
    end
    z0 = point(3)-z1;
end