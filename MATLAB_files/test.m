points = containers.Map();
points('A') = [0, 0, 0];
points('B') = [3*sqrt(5), 0, 0];
points('C') = [3*sqrt(5), 0, 1];

points1 = containers.Map();
points1('D') = points('A');
points1('E') = [5, 2, 4];

temp = points1('E')-points('B');
u = [0, 0, 1];
s = u;
w = s;
v = s;
a = get_rotation_angles(temp);
txt = ["A", a('X'), a('Y'), a('Z')];
disp(txt);

u = u*rotz(a('Z')*180/pi)*roty(a('Y')*180/pi)*rotx(a('X')*180/pi);
disp(u);

w = w*rotx(a('X')*180/pi)*roty(a('Z')*180/pi)*rotz(a('Y')*180/pi);
disp(w);

v = roty(a('Y')*180/pi)*rotz(a('Z')*180/pi)*rotx(a('X')*180/pi);
disp(v);

points1('F') = points1('E')+u;

plot_points(points, -100, "", [-3, 18, -6, 6, 0, 15]);
plot_points(points1, -100, "", [-3, 18, -6, 6, 0, 15]);

