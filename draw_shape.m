function[] = draw_shape()
    r = 1;
    t = linspace(1, 10);
    zz = r*cos(t);
    yy = r*sin(t);
    line(zz, yy);
end