function[x, y, z, theta_x] = get_IK_points(i, r, xdist, zdist)
    x = xdist;
    y = r*cos(i);
    z = r*sin(i)+zdist;
    theta_x = i;
end 