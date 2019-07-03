x = 7;
y = 2;
z = 11;

theta_x = pi/4;
theta_y = pi/6;

z1 = y*tan(theta_x);
z0 = z-z1;

arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 4;
arms_lengths('EF') = 4;

points = containers.Map();
points('A') = [0, 0, 0];
points('B') = [0, 0, z0];
points('C') = [arms_lengths('BC'), 0, z0];
points('D') = [-1, -1, -1];
points('E') = [x-cos(theta_y)*arms_lengths('CD'), sin(theta_y)*arms_lengths('CD')*sin(theta_x)+y, sin(theta_y)*arms_lengths('CD')*sin(theta_x)+z];
points('F') = [x, y, z];

arms_lengths('CE') = norm(points('E')-points('C'));

if(norm(points('F')-points('C')) > arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF'))
    error("Not possible 1");
end 

if(triangle_inequality(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))==-1)
    error("Not possible 2");
end 

vectors = containers.Map();
vectors('CE') = points('E') - points('C');
vectors('CF') = points('F') - points('C');
vectors('cross1') = cross(vectors('CE'), vectors('CF'));
vectors('cross2') = cross(vectors('CE'), vectors('cross1'));

height = 2*heron(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))/arms_lengths('CE');

vectors('CG') = sqrt(arms_lengths('CD')^2-height^2)*vectors('CE')/norm(vectors('CE'));
vectors('GD') = height*vectors('cross2')/norm(vectors('cross2'));
vectors('CD') = vectors('CG')+vectors('GD');

points('D') = points('C')+vectors('CD');

angles = containers.Map();
angles('C') = cosine_law_angle(norm(points('C')-points('B')), arms_lengths('CD'), norm(points('D')-points('B')));
angles('D') = cosine_law_angle(arms_lengths('CD'), arms_lengths('DE'), norm(points('E')-points('C')));
angles('E') = cosine_law_angle(arms_lengths('DE'), arms_lengths('EF'), norm(points('F')-points('D')));
temp = points('D');
angles('T') = atan((temp(3)-z0)/temp(2));

x_val = [];
y_val = [];
z_val = [];

k = keys(points);
val = values(points);

for i = 1:length(points)
    x_val(end+1) = val{i}(1);
    y_val(end+1) = val{i}(2);
    z_val(end+1) = val{i}(3);
    scatter3(x_val, y_val, z_val);
    hold on;
end

plot3(x_val, y_val, z_val);