set_real_arms_lengths(5);
global arms_lengths;
for i = 1:50
    
   [x, y, z, ~, ~, ~] = get_real_inverse_inputs();
    theta_x = i*(pi/2)/50; %in radians
    theta_y = -pi/2;

   sign = -1;
   z0 = get_z0([x, y, z], theta_x, theta_y);
   if z0 == -100
       continue;
   end
   
   arms_lengths('AB') = z0;
   
   [angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1);

   if isa(angles, 'containers.Map') && isa(points, 'containers.Map')
       disp(theta_x);
   else
       z0 = get_z0([x, y, z], theta_x, theta_y);
      [angles, points] = IK(x, y, z, theta_x, theta_y, z0, -1);
       if isa(angles, 'containers.Map') && isa(points, 'containers.Map')
            disp(theta_x);
       end
   end
end