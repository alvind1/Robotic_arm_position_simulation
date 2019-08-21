function[z0] = get_z0(point, theta_x, theta_y)
    global arms_lengths;
    if abs(mod(theta_x, pi/2)-pi/2) > 0.1 && point(2) ~= 0
        z1 = point(2)*tan(theta_x);
        z0 = point(3)-z1;
    else %Need case when point(2) == 0
%         x = point(1);
%         y = point(2);
%         z = point(3);
%         pointE = [x-cos(theta_y)*arms_lengths('EF'), y+sin(theta_y)*arms_lengths('EF')*cos(theta_x), z+sin(theta_y)*arms_lengths('EF')*sin(theta_x)];
%         z0 = sqrt((arms_lengths('CD')-arms_lengths('DE'))^2-(pointE(1)-arms_lengths('AB'))^2-pointE(2)^2)+pointE(3);
        z1 = 0; %Arbitrary value since many possible solutions
        z0 = point(3)-z1;
    end
end