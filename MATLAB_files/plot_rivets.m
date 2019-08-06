function[] = plot_rivets(x, y, z, theta)
    r = 0.3;
    t = linspace(0, 2*pi);
    rx(1:100) = x-r*cos(t)*sin(theta);
    ry = r*cos(t)*cos(theta)+y;
    rz = r*sin(t)+z;
    patch(rx, ry, rz, "Black");
end