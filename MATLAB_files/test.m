%% Constants
grid on;
axis manual;

xmin = 0;
xmax = 19;
ymin = -10;
ymax = 10;
zmin = 0;
zmax = 15;
ax = ([xmin, xmax, ymin, ymax, zmin, zmax]);

x = 14; %Target Coordinates
y = -3;
z = 11;
theta_x = 0.3; 
theta_y = 0.2;

z1 = y*tan(theta_x);
z0 = z-z1;

arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

start_x = arms_lengths('BC'); %Starting Position
start_y = 15;
start_z = 5; 
start_theta_x = 0;
start_theta_y = -pi/2;
start_z0 = start_z-start_y*tan(start_theta_x);

cx = 13; %Hole coordinates
cy = 0;
cz = 10;
cr = 2; %Hole radius



[initial_angles, initial_points]  = IK(start_x, start_y, start_z, start_theta_x, start_theta_y, start_z0, 1, arms_lengths); 

xs1 = cx-2;
ys1 = cy;
zs1 = cz;
theta_xs1 = 0;
theta_ys1 = pi/4;
z0s1 = zs1-ys1*tan(theta_xs1);
[s1_angles, s1_points] = IK(xs1, ys1, zs1, theta_xs1, theta_ys1, z0s1, 1, arms_lengths);
if(s1_angles <= -100 && s1_points <= -100)
    error("S1");
end

xs2 = cx;
ys2 = cy;
zs2 = cz;
theta_xs2 = 0;
theta_ys2 = pi/4;
z0s2 = zs2-ys2*tan(theta_xs2);
[s2_angles, s2_points] = IK(xs2, ys2, zs2, theta_xs2, theta_ys2, z0s2, 1, arms_lengths);

[angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1, arms_lengths);
if angles <= -100 && points <= -100
    error("TARGET");
end


f_animate(initial_angles, s1_angles, start_z0, z0s1, ax, arms_lengths, 0);
f_animate(s1_angles, s2_angles, z0s1, z0s2, ax, arms_lengths, 0);
f_animate(s2_angles, angles, z0s2, z0, ax, arms_lengths, 1);