arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

angles = containers.Map();
angles('C') = 1.5708; %Range: 0 <= theta <= pi
angles('D') = 0; %Range: 0 <= theta <= pi
angles('E') = 0; %Range: 0 <= theta <= pi
angles('T') = 0;  %Range: 0 <= theta <= pi/2
z0 = 5;

[points, s] = FK(angles, z0, arms_lengths);
print_points(points);