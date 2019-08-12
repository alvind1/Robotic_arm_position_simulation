function[point, theta_x, theta_y] = get_s1_points(theta, ppoint)
   v = [-abs(cos(theta)), -sin(theta), 0];
   point = ppoint+v;
   theta_y = theta;
   theta_x = pi/2; %FIXME
end