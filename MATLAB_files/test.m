for i = 1:50
   x = 32;
   y = 6;
   z = 12;
   theta_x = 2*pi*i/100;
   theta_y = 0;
   sign = -1;
   z0 = get_z0([x, y, z], theta_x, theta_y);

   [angles, points] = IK(x, y, z, theta_x, theta_y, z0, sign);
   if isa(angles, 'containers.Map') && isa(points, 'containers.Map')
       disp(theta_x);
   end
end