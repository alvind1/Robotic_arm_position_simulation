%% Constants
grid on;
axis manual;

xmin = 0;
xmax = 19;
ymin = -10;
ymax = 10;
zmin = 0;
zmax = 15;

x = 12.5;
y = 2;
z = 11;
theta_x = 0.3; 
theta_y = 0.2;

z1 = y*tan(theta_x);
z0 = z-z1;

set_arms_lengths(z0);
global arms_lengths;

start_x = arms_lengths('BC');
start_y = 15;
start_z = 5; 
start_theta_x = 0;
start_theta_y = -pi/2;
start_z0 = start_z-start_y*tan(start_theta_x);

[initial_angles]  = IK(start_x, start_y, start_z, start_theta_x, start_theta_y, start_z0, 1); 
[angles, points] = IK(x, y, z, theta_x, theta_y, z0, 1);

%TODO: Check if animation can start from any given position

n = 100;

[cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords();
plot_board();

hold on;

%%
for j = 0:n
    [temp_angles, temp_z0] = get_angles_naive(j, n, angles, initial_angles, z0, start_z0);
    %txt = [temp_angles('C'), temp_angles('D'), temp_angles('E'), temp_angles('T')];
    %disp(txt);
    [points, scenario] = FK(temp_angles, temp_z0);
        
    x_val = zeros(1, 6);
    y_val = zeros(1, 6);
    z_val = zeros(1, 6);
    splt = zeros(1, 6);
    tplt = zeros(3, 6);
    

    k = keys(points);
    val = values(points);
    length_val = values(arms_lengths);
    
    for i = 1:length(points)
        if ismissing(points(k{i}))
            txt = [temp_angles('C'), temp_angles('D'), temp_angles('E'), temp_angles('T'), temp_z0, i];
            disp(txt);
            txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
            disp(txt);
            error("A");
        end
        
        x_val(i) = val{i}(1);
        y_val(i) = val{i}(2);
        z_val(i) = val{i}(3);
        splt(i) = scatter3(x_val, y_val, z_val); %Draw
        
        if(i ~= 1) %Print lengths
            tplt(1, i) = text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
        end

        if(i ~= 1 && i ~= 2 && i ~= 6)
            tplt(2,  i) = text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(temp_angles(k{i})), 'Color', 'r');
        end 

        if (i == 3)
            txt = ["Plane rotation", num2str(temp_angles('T'))];
            tplt(3, i) = text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt, 'Color', 'r');
        end 
        
        if(abs(arms_lengths('EF')-norm(points('F')-points('E'))) > 0.1)
            error("EF OFF");
        end 
        
        if(abs(norm(points('E')-points('D'))-arms_lengths('DE')) > 0.1)
            error("DE OFF");
        end 
       
        if i ~= 6 && check_segmentboard_intersection(points(k{i}), points(k{i+1})-points(k{i})) == -1
%             txt = [plane, "B", ppoint, "B",  points(k{i}), "B", points(k{i+1})-points(k{i}), "B", board, "B", i, k{i+1}, "B", points('E')];
%             disp(txt);
%             txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
%             disp(txt);
            error("BOARD INTERSECTION");
        end
        
    end
    
    plt = plot3(x_val, y_val, z_val); %Draw
    axis([xmin, xmax, ymin, ymax, zmin, zmax]);
    
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    drawnow;
    
    if j ~= n
        delete(plt);
        delete(splt);
        delete(tplt);
    end
    
end

disp("DONE");
