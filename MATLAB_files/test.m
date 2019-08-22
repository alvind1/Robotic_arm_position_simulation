set_arms_lengths(5);
global arms_lengths;

hold on;
for i = 50:-1:1
   theta_x = i*(pi/2)/50;
   theta_y = pi;
   x = 12;
   y = 0;
   z = 7;
   
   z0 = get_z0([x, y, z], theta_x, theta_y);
   arms_lengths('AB') = z0;
   
   [angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1);
   
   animate_func(angles, points, z0, 1, 0, 50);
end