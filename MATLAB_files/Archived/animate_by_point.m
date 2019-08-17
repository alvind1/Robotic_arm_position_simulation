function[] = animate_by_point(start_point, start_theta_x, start_theta_y, end_point, end_theta_x, end_theta_y, p, n)
    %% Constants
    grid on;
    axis manual;
    global arms_lengths;

    hold on;
    
    start_z0 = get_z0(start_point, start_theta_x, start_theta_y); %Still need to find use for these 
    end_z0 = get_z0(end_point, end_theta_x, end_theta_y);
    
    temp_theta_y = start_theta_y;

    %%
    for j = 0:n
        [temp_point] = get_point(j, n, start_point, end_point);
        [temp_z0] = get_z0(temp_point, start_theta_x);
        arms_lengths('AB') = temp_z0;
        [temp_theta_y] = get_theta_y(temp_theta_y, start_theta_x, temp_z0, temp_point);
        %txt = [temp_angles('C'), temp_angles('D'), temp_angles('E'), temp_angles('T')];
        %disp(txt);
        [temp_angles, points] = IK(temp_point(1), temp_point(2), temp_point(3), start_theta_x, temp_theta_y, temp_z0, 1);
        if(points <= -100 && temp_angles <= -100)
            if(points == -100 && temp_angles == -100)
                error("LENGTH");
            elseif(points == -200 && temp_angles == -200)
                error("TRIANGLE_INEQUALITY");
            elseif(points == -300 && temp_angles == -300)
                error("OVERLAP SEGMENTS");
            elseif(points == -400 && temp_angles == -400)
                error("NEGATIVE");
            elseif(points == -500 && temp_angles == -500)
                error("BOARD INTERSECTION");
            end
        end
        
        animate_func(temp_angles, points, temp_z0, j, p, n);
    end

    disp("DONE");
end