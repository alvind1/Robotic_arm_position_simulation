axis_dim = [0, 18, -6, 6, 0, 16];

%Givens
angles = containers.Map();
angles('C') = 2.4033;
angles('D') = 1.1670;
angles('E') = 2.7653;
angles('T') = 1.4834;
z0 = 3.2463;
scenario = 0;

arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

points = containers.Map();
points('A') = [0, 0, 0];
points('B') = [0, 0, z0];
points('C') = [arms_lengths('BC'), 0, z0];
points('D') = [arms_lengths('CD')*cos(angles('C'))+arms_lengths('BC'), sin(angles('C'))*arms_lengths('CD')*cos(angles('T')), arms_lengths('CD')*sin(angles('C'))*sin(angles('T'))+z0];

arms_lengths('CE') = cosine_law_side(arms_lengths('CD'), arms_lengths('DE'), pi-angles('D'));
angles('temp1') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'));
points('E') = [arms_lengths('CE')*cos(angles('temp1'))+arms_lengths('BC'), arms_lengths('CE')*sin(angles('temp1'))*cos(angles('T')), arms_lengths('CE')*sin(angles('temp1'))*sin(angles('T'))+z0];

if angles('E')+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) < pi
    temp3_angle =  pi-angles('E')-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
    scenario = 1;
else
    temp3_angle = angles('E')+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) - pi;
    scenario = 2;
end

arms_lengths('CF') = cosine_law_side(arms_lengths('CE'), arms_lengths('EF'), temp3_angle);
if scenario == 1
    angles('temp2') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
elseif scenario == 2
    angles('temp2') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
end
points('F') = [arms_lengths('CF')*cos(angles('temp2'))+arms_lengths('BC'), arms_lengths('CF')*sin(angles('temp2'))*cos(angles('T')), arms_lengths('CF')*sin(angles('temp2'))*sin(angles('T'))+z0];

e = points('E');
f = points('F');
theta_y = acos((f(1)-e(1))/arms_lengths('EF'));
if e(3) < f(3)
    theta_y = -theta_y;
end 

output = [points('F'), angles('T'), theta_y]
grid on;
%figure(2);
plot_points(points, angles,'FK', axis_dim); 

remove(arms_lengths, 'CE');
remove(arms_lengths, 'CF');

checkFK(points, angles, arms_lengths);
txt_points = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
disp(txt_points);
disp(abs(f(3)-z0-f(2)*tan(angles('T'))));

%% TODO
%Check if angles match

