n = 100;
angles = containers.Map();

arms_lengths = containers.Map();
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;
errors = [0, 0, 0, 0];

c = 0;
i = 0;
while (i<100)
    c = c+1;
    if c >= 2000
        break;
    end
    z0 = 8*rand(1, 1)+2;
    angles('C') = (2*pi)*rand(1, 1)-pi;
    angles('D') = (2*pi)*rand(1, 1)-pi;
    angles('E') = (2*pi)*rand(1, 1)-pi;
    angles('T') = (pi)*rand(1, 1)-pi/2;
    arms_lengths('AB') = z0;
    
    %To DO
    %Calibrate scenario
    %Fix IK_condition(line intersection)
    
    check = 1;
    
    [points, scenario] = FK(angles, z0, arms_lengths);
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
    
    check = IK_conditions(points, arms_lengths, 1);

    if check <= -1
        errors(check*-1) = errors(check*-1)+1;
        continue;
    end
    
    try
        [got_angles, got_points] = IK(f(1), f(2), f(3), angles('T'), theta_y, z0, 1, arms_lengths);
        k = keys(got_angles);
        v = values(got_angles);
        for j=1:length(got_angles)
            if abs(mod(got_angles(k{j}), pi)-mod(angles(k{j}), pi)) > 0.01
%                 txt = [angles('C'), angles('D'), angles('E'), angles('T'), z0];
%                 disp(txt);
%                 txt = [got_angles('C'), got_angles('D'), got_angles('E')];
%                 disp(txt);
                error("ANGLE_DIFF");
                check = -1;
                break;
            end

            if k{j} ~= 'T'
                if max(abs(points(k{j})-got_points(k{j}))) > 0.01
%                     disp(j)
                    error("POINT_DIFF");
                    check = -1;
                    break;
                end
            end
        end
    catch
        [got_angles, got_points] = IK(f(1), f(2), f(3), angles('T'), theta_y, z0, -1, arms_lengths);
        k = keys(got_angles);
        v = values(got_angles);
        for j=1:length(got_angles)
            if abs(mod(got_angles(k{j}), pi)-mod(angles(k{j}), pi)) > 0.01
                txt = [angles('C'), angles('D'), angles('E'), angles('T'), z0];
                disp(txt);
                txt = [got_angles('C'), got_angles('D'), got_angles('E')];
                disp(txt);
                error("ANGLE_DIFF");
                check = -1;
                break;
            end
            
            %txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
            %txt = [got_points('A'); got_points('B'); got_points('C'); got_points('D'); got_points('E'); got_points('F')];

            if k{j} ~= 'T'
                if max(abs(points(k{j})-got_points(k{j}))) > 0.01
                    disp(j)
                    error("POINT_DIFF");
                    check = -1;
                    break;
                end
            end
        end
    end

    i = i+1;
end

disp("PROGRAM_DONE");
disp(i);
disp(c);
disp(errors);
%% Bugs
