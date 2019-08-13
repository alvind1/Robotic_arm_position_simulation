function[ax] = get_ax_dim()
    global ax;
    xmin = 0;
    xmax = 19;
    ymin = -10;
    ymax = 20;
    zmin = 0;
    zmax = 15;
    ax = ([xmin, xmax, ymin, ymax, zmin, zmax]);
end