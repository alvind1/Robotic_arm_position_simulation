n = 1000;
angles = containers.Map();

arms_lengths = containers.Map();
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;
max_x = arms_lengths('BC')+arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF');
max_y = 5;
max_z = 12;

i = 1;

%[got_angles, got_points] = IK(x, y, z, theta_x, theta_y, z0, 1, arms_lengths);

while(i <= 1000)
    x = 3+max_x*rand(1, 1);
    y = max_y*rand(1, 1);
    z = 2+max_z*rand(1, 1);
    theta_x = (pi/2)*rand(1, 1);
    theta_y = (pi/2)*rand(1, 1);
    
    z1 = y*tan(theta_x);
    z0 = z-z1;
    
    arms_lengths('AB') = z0;
    
    [got_angles, got_points] = IK(x, y, z, theta_x, theta_y, z0, 1, arms_lengths);
    
    if(got_angles == -1 && got_points == -1) %Checks triangle inequality and if any points are negative in x or z
        continue
    end
   
    got_val = values(got_points);
    k = keys(got_points);
    
    for j = 2:length(k) %Checks if arm segments overlap
        for m = j+1:length(k)
            [check] = check_line_intersection(got_val{j-1}, got_val{j}, got_val{m-1}, got_val{m});
            if check == -1
                break;
            end
        end
        if check == -1
            break;
        end
    end
    if check == -1
        continue;
    end
    
    
    [target_points, scenario] = FK(got_angles, z0, arms_lengths);
    target_val = values(target_points);
    
    if max(abs(got_val{6}-target_val{6})) > 0.01
        temp = target_val{6};
        txt = [x, y, z, theta_x, theta_y, temp(1), temp(2), temp(3)];
        disp(txt);
        error("POINT ERROR");
    end
    
%     for j = 1:length(got_points)
%         if max(abs(got_val{j}-target_val{j})) > 0.01
%             disp(j);
%             disp(k{j});
%             txt = [got_val{j}; target_val{j}];
%             disp(txt);
%             error("POINT ERROR");
%         end
%     end
    
    i = i+1;
end

disp("PROGRAM_DONE");