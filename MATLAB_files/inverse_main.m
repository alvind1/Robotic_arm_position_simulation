%% GIVENS
grid on;

set_arms_lengths(5); %5 is an arbitrary z0 since we will reset it later
%set_real_arms_lengths(5);
global arms_lengths;

[x, y, z, theta_x, theta_y, z0] = get_inverse_inputs();
%[x, y, z, theta_x, theta_y, z0] = get_real_inverse_inputs();
arms_lengths('AB') = z0;

plot_board();
%plot_real_board();

get_ax_dim();
sign = -1; %Could be +- 1 since for every x, y, z, theta_x, theta_y there are two solutions

%% CALCULATIONS
points = containers.Map();
points('A') = [0, 0, 0];
points('B') = [0, 0, z0];
points('C') = [arms_lengths('BC'), 0, z0];
points('D') = [-1, -1, -1];
points('E') = [x-cos(theta_y)*arms_lengths('EF'), y+sin(theta_y)*arms_lengths('EF')*cos(theta_x), z+sin(theta_y)*arms_lengths('EF')*sin(theta_x)];
points('F') = [x, y, z];

arms_lengths('CE') = norm(points('E')-points('C'));

check = IK_conditions(points, 0); %Checks the length is reachable and the triangle inequality is satisfied by givens
if check ~= 1
    print_points(points);
    if check == -1
        error("LENGTH");
    elseif check == -2
        error("TRIANGLE INEQUALITY");
    elseif check == -3
        error("OVERLAP SEGMENTS");
    elseif check == -4
        error("NEGATIVE");
    elseif check == -5
        error("BOARD INTERSECTION");
    end
end

vectors = containers.Map();
vectors('CE') = points('E') - points('C');
vectors('CF') = points('F') - points('C');
vectors('cross1') = [0, cos(pi/2+theta_x), sin(pi/2+theta_x)]; %cross(vectors('CE'), vectors('CF')); 
vectors('cross2') = sign*cross(vectors('CE'), vectors('cross1'));

height = 2*heron(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))/arms_lengths('CE');

vectors('CG') = sqrt(arms_lengths('CD')^2-height^2)*vectors('CE')/norm(vectors('CE'));
if sqrt(arms_lengths('DE')^2-height^2) >= norm(points('E')-points('C'))
    vectors('CG') = -vectors('CG');
end 

if norm(vectors('cross2')) ~= 0
    vectors('GD') = height*vectors('cross2')/norm(vectors('cross2'));
else
    vectors('GD') = 0;
end

vectors('CD') = vectors('CG')+vectors('GD');

points('D') = points('C')+vectors('CD');

check = IK_conditions(points, 1);
if check ~= 1
    print_points(points);
    if check == -1
        error("LENGTH");
    elseif check == -2
        error("TRIANGLE INEQUALITY");
    elseif check == -3
        error("OVERLAP SEGMENTS");
    elseif check == -4
        error("NEGATIVE");
    elseif check == -5
        %error("BOARD INTERSECTION");
        disp("BOARD INTERSECTION");
    end
end

angles = containers.Map();
signs = angle_direction(points, theta_x, z0, 1);

angles('C') = pi-cosine_law_angle(norm(points('C')-points('B')), arms_lengths('CD'), norm(points('D')-points('B')));
angles('C') = angles('C')*signs('C');
angles('D') = pi-cosine_law_angle(arms_lengths('CD'), arms_lengths('DE'), norm(points('E')-points('C')));
angles('D') = angles('D')*signs('D');
angles('E') = pi-cosine_law_angle(arms_lengths('DE'), arms_lengths('EF'), norm(points('F')-points('D')));
angles('E') = angles('E')*signs('E');

angles('T') = theta_x;

figure(1);
plot_points(points, angles, 'IK');

txt = [angles('C'), angles('D'), angles('E'), angles('T'), z0]; %FOR FORWARD_MAIN USE IN RADIANS
disp(txt);
txt = [angles('C')*180/pi, angles('D')*180/pi, angles('E')*180/pi, angles('T')*180/pi-90, z0]; %FOR ROBOT USE IN DEGREES
disp(txt);
print_points(points);

%% To Dos
