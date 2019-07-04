%% Constants
grid on;
xlim = ([0, 10]);
ylim([-5, 5]);
zlim = ([0, 10]);
axis manual;

xmin = 0;
xmax = 12;
ymin = -6;
ymax = 6;
zmin = 0;
zmax = 12;

theta_y = pi/8;

%%
for j = 1:10000
    r = 1;
    xdist = 11;
    zdist = 3;
    
    [x, y, z, theta_x] = get_points(j/10, r, xdist, zdist);
    
    z1 = abs(y)*tan(theta_x); %Weird jump 
    z0 = z-z1;
    
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
    points('D') = [-1, -1, -1];
    points('E') = [x-cos(theta_y)*arms_lengths('EF'), y+sin(theta_y)*arms_lengths('EF')*cos(theta_x), z+sin(theta_y)*arms_lengths('EF')*sin(theta_x)];
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
    if sqrt(arms_lengths('DE')^2-height^2) >= norm(points('E')-points('C'))
        vectors('CG') = -vectors('CG');
    end 
    
    vectors('GD') = height*vectors('cross2')/norm(vectors('cross2'));
    vectors('CD') = vectors('CG')+vectors('GD'); %TODO: Account for cases where G lies outside CE

    points('D') = points('C')+vectors('CD');

    angles = containers.Map();
    angles('C') = pi-cosine_law_angle(norm(points('C')-points('B')), arms_lengths('CD'), norm(points('D')-points('B')));
    angles('D') = pi-cosine_law_angle(arms_lengths('CD'), arms_lengths('DE'), norm(points('E')-points('C')));
    angles('E') = pi-cosine_law_angle(arms_lengths('DE'), arms_lengths('EF'), norm(points('F')-points('D')));
    temp = points('D');
    angles('T') = atan((temp(3)-z0)/temp(2));

    x_val = [];
    y_val = [];
    z_val = [];

    k = keys(points);
    val = values(points);
    length_val = values(arms_lengths);
    
    for i = 1:length(points)
        x_val(end+1) = val{i}(1);
        y_val(end+1) = val{i}(2);
        z_val(end+1) = val{i}(3);
        scatter3(x_val, y_val, z_val); %Draw
        
        if(i ~= 1) %Print lengths
            text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
        end

        if(i ~= 1 && i ~= 2 && i ~= 6)
            text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(angles(k{i})), 'Color', 'r');
        end 

        if (i == 3)
            txt = ["Plane rotation", num2str(angles('T'))];
            text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt, 'Color', 'r');
        end 
        
        if(abs(arms_lengths('EF')-norm(points('F')-points('E'))) > 0.1)
            error("EF OFF");
        end 
        
        if(abs(norm(points('E')-points('D'))-arms_lengths('DE')) > 0.1)
            error("DE OFF");
        end 
        
        hold on;
    end

    plot3(x_val, y_val, z_val); %Draw
    axis([xmin, xmax, ymin, ymax, zmin, zmax]);
    
    t = linspace(1, 100);
    xcircle = xdist.*ones(size(t));
    ycircle = r*cos(t);
    zcircle = r*sin(t)+zdist;
    line(xcircle, ycircle, zcircle);
    
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    drawnow;
    hold off;
    
    pause(0.1);
end
