for i = 1:50
    for j = 1:50
       [x, y, z, ~, ~, ~] = get_inverse_inputs();
       theta_x = pi/2-i*(pi/2)/50;
       
       if round(j/2) == round((j-1)/2)
            theta_y = j*(pi/2)/25;
       else
           theta_y = -j*(pi/2)/25;
       end
       
       sign = -1;
       z0 = get_z0([x, y, z], theta_x, theta_y);
       [angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1);
       
       if isa(angles, 'containers.Map') && isa(points, 'containers.Map')
           disp(theta_x);
           pause();
       else
           z0 = get_z0([x, y, z], theta_x, theta_y);
          [angles, points] = IK(x, y, z, theta_x, theta_y, z0, -1);
           if isa(angles, 'containers.Map') && isa(points, 'containers.Map')
                disp(theta_x);
                disp(theta_y);
                pause();
           end
       end
       
       disp(j);
    end
    disp(i);
end