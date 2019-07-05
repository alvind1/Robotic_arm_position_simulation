%% Constants
grid on;
axis manual;

xmin = 0;
xmax = 15;
ymin = -8;
ymax = 8;
zmin = 0;
zmax = 15;

x = 11;
y = 0;
z = 8;
theta_x = 0; %May not be given
theta_y = 0.7; 

z1 = y*tan(theta_x);
z0 = z-z1;

arms_lengths = containers.Map();
arms_lengths('AB') = z0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

start_x = arms_lengths('BC')+arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF');
start_y = 0;
start_z = 7; %Arbitrary
start_theta_y = 0;
start_theta_x = 0;

[angles] = IK(x, y, z, theta_x, theta_y, z0);

n = 200;

%%
for j = 0:n
    temp_angles = get_angles(j, n, angles);
    temp_angles('C')
    points = FK(temp_angles, z0);
        
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
    
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    drawnow;
    hold off;
    
    pause(0.02);
end

disp("DONE");
