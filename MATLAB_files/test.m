t = linspace(0, 2*pi);
x1 = cos(t);
x1 = reshape(x1, [100, 1]);
y1 = sin(t);
y1 = reshape(y1, [100, 1]);
x2 = 0.5*cos(t);
y2 = 0.5*sin(t);
pgon = alphaShape(x1, y1, 'red');
plot(pgon);