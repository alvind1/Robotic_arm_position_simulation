set_arms_lengths(5);
global arms_lengths;

hold on;

plot_board();

n = 100;
for i = 1:n
   theta_x = (i*2*pi)/n;
   theta_y = pi;
   x = 12+0.3;
   y = 0;
   z = 7;
   
   z0 = get_z0([x, y, z], theta_x, theta_y);
   arms_lengths('AB') = z0;
   
   [angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1);
   
   animate_func(angles, points, z0, i, 1, n);
end