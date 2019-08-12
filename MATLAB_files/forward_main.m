axis_dim = [0, 18, -9, 6, 0, 16];

%Givens
angles = containers.Map();
angles('C') = pi/2; %Range: 0 <= theta <= pi
angles('D') = pi; %Range: 0 <= theta <= pi
angles('E') = pi/2; %Range: 0 <= theta <= pi
angles('T') = pi/2;  %Range: 0 <= theta <= pi/2
z0 =11;

%All positive angles works
%All positive & angles('E') < 0 works

scenario = 0; %Not given

arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

%% Start of FK Function
points = containers.Map();
points('A') = [0, 0, 0];
points('B') = [0, 0, z0];
points('C') = [arms_lengths('BC'), 0, z0];
points('D') = [arms_lengths('CD')*cos(angles('C'))+arms_lengths('BC'), sin(angles('C'))*arms_lengths('CD')*cos(angles('T')), arms_lengths('CD')*sin(angles('C'))*sin(angles('T'))+z0];

arms_lengths('CE') = cosine_law_side(arms_lengths('CD'), arms_lengths('DE'), pi-abs(angles('D')));
angles('temp1') = angles('C')+cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))*angles('D')/abs(angles('D')); %Angle C to E
if angles('D') == 0
    angles('temp1') = angles('C');
end
points('E') = [arms_lengths('CE')*cos(angles('temp1'))+arms_lengths('BC'), arms_lengths('CE')*sin(angles('temp1'))*cos(angles('T')), arms_lengths('CE')*sin(angles('temp1'))*sin(angles('T'))+z0];
%DONE up to here

%Should all work
if angles('C') >= 0 %Works
    if angles('D') >= 0 %Works
        if angles('E') >= 0
            if abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) < pi
                temp3_angle =  pi-abs(angles('E'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 1;
            else
                temp3_angle = abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) - pi;
                scenario = 2;
            end
        elseif angles('E') < 0
            if abs(angles('E')) <= cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))
                temp3_angle = pi+abs(angles('E'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 1;
            elseif abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) > pi
                temp3_angle = -abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) + pi;
                scenario = 2;
            else %in between previous cases
                temp3_angle = pi-abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 2;
            end
        end
    else
        if angles('E') >= 0 %Works
            if angles('E') <= cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))
                temp3_angle = pi-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))+abs(angles('E'));
                scenario = 2;
            else
                temp3_angle = pi-abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 1;
            end
        else %Works
            if abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) <= pi
                temp3_angle = pi-abs(angles('E'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 2;
            else
                temp3_angle = abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))-pi;
                scenario = 1;
            end
        end
    end
else
    if angles('D') >= 0 
        if angles('E') >= 0
            if abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) < pi
                temp3_angle =  pi-abs(angles('E'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 1;
            else
                temp3_angle = abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) - pi;
                scenario = 2;
            end
        elseif angles('E') < 0
            disp("A");
            if abs(angles('E')) <= cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))
                temp3_angle = pi+abs(angles('E'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 1;
            elseif abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) > pi
                temp3_angle = -abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) + pi;
                scenario = 2;
            else %in between previous cases
                temp3_angle = pi-abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 2;
            end
        end
    else
        if angles('E') >= 0 
            if angles('E') <= cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))
                temp3_angle = pi-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))+abs(angles('E'));
                scenario = 2;
            else
                temp3_angle = pi-abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 1;
            end
        else 
            if abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) <= pi
                temp3_angle = pi-abs(angles('E'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
                scenario = 2;
            else
                temp3_angle = abs(angles('E'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'))-pi;
                scenario = 1;
            end
        end
    end
end
    
arms_lengths('CF') = cosine_law_side(arms_lengths('CE'), arms_lengths('EF'), temp3_angle);

if scenario == 1
    angles('temp2') = angles('temp1')+cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
elseif scenario == 2
    angles('temp2') = angles('temp1')-cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
end

points('F') = [arms_lengths('CF')*cos(angles('temp2'))+arms_lengths('BC'), arms_lengths('CF')*sin(angles('temp2'))*cos(angles('T')), arms_lengths('CF')*sin(angles('temp2'))*sin(angles('T'))+z0];
%End of FK function

%% 
e = points('E');
f = points('F');
theta_y = acos(abs((f(1)-e(1)))/arms_lengths('EF'));
sign = angle_direction(points, z0, 2);
if sign == 2
    theta_y = pi-theta_y;
elseif sign == 3
    theta_y = -pi+theta_y;
elseif sign == 4
    theta_y = -theta_y;
end

output = [points('F'), angles('T'), theta_y]
grid on;
figure(2);
plot_points(points, angles,'FK', axis_dim); 

remove(arms_lengths, 'CE');
remove(arms_lengths, 'CF');

checkFK(points, angles, arms_lengths);
txt_points = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
disp(txt_points);

%% TODO
%Check if angles match

