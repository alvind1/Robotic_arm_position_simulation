function[point, theta_x, theta_y] = get_s2_points(board_theta, ppoint)
    point = ppoint;
    point(1) = point(1) + 5;
    theta_x = pi/2;
    theta_y = 0;
end