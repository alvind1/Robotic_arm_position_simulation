grid on;

xmin = 0;
xmax = 18;
ymin = -6;
ymax = 6;
zmin = 0;
zmax = 12;

%Givens
angles = containers.Map();
angles('C') = 0.6;
angles('D') = 0;
angles('E') = 0;
angles('T') = 0.8;

z0 = 4;

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

arms_lengths('CF') = cosine_law_side(arms_lengths('CE'), arms_lengths('EF'), pi-angles('E')-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')));
angles('temp2') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
points('F') = [arms_lengths('CF')*cos(angles('temp2'))+arms_lengths('BC'), arms_lengths('CF')*sin(angles('temp2'))*cos(angles('T')), arms_lengths('CF')*sin(angles('temp2'))*sin(angles('T'))+z0];

e = points('E');
f = points('F');
theta_y = acos((f(1)-e(1))/arms_lengths('EF'));
output = [points('F'), angles('T'), theta_y]

x_val = [];
y_val = [];
z_val = [];

k = keys(points);
val = values(points);

for i = 1:length(points)
    x_val(end+1) = val{i}(1);
    y_val(end+1) = val{i}(2);
    z_val(end+1) = val{i}(3);
    scatter3(val{i}(1), val{i}(2), val{i}(3));
    text(val{i}(1), val{i}(2), val{i}(3), k(i));
    
    if(i ~= 1) %Print lengths
        text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
    end
    
    if(i ~= 1 && i ~= 2 && i ~= 6)
        text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(angles(k{i})), 'Color', 'r');
    end 
    
    if (i == 3)
        txt = ["Plane rotation", num2str(angles('T'))];
        text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt);
    end 
    
    hold on;
end

plot3(x_val, y_val, z_val);
axis([xmin, xmax, ymin, ymax, zmin, zmax]);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('FK');