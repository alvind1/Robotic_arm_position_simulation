n = 1000;
angles = containers.Map();

arms_lengths = containers.Map();
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;
type = [0, 0];
angle_type = [[0, 0, 0, 0, 0]; [0, 0, 0, 0, 0]];

for i = 1:n
    z0 = 8*rand(1, 1)+2;
    angles('C') = (pi)*rand(1, 1);
    angles('D') = (pi)*rand(1, 1);
    angles('E') = (pi)*rand(1, 1);
    angles('T') = (pi/2)*rand(1, 1);
    arms_lengths('AB') = z0;
    
    %Have not checked larger than pi/2 and negative values
    
    check = 1;
    
    [points, scenario] = FK(angles, z0, arms_lengths);
    e = points('E');
    f = points('F');
    theta_y = acos((f(1)-e(1))/arms_lengths('EF'));
    if e(3) < f(3)
        theta_y = -theta_y;
    end 
    
    [got_angles, got_points] = IK(f(1), f(2), f(3), angles('T'), theta_y, z0, 1, arms_lengths);
    
    k = keys(got_angles);
    v = values(got_angles);
    
    for j=1:length(got_angles)
        
        if abs(mod(got_angles(k{j}), pi)-mod(angles(k{j}), pi)) > 0.01
            txt = [got_angles(k{j}), angles(k{j})]; 
            %disp(txt);
            txt_angles = [angles('C'), angles('D'), angles('E'), angles('T'), z0];
            %disp(txt_angles);
            %error("ANGLE_DIFF");
            check = -1;
            break;
        end
        
        if k{j} ~= 'T'
            if max(abs(points(k{j})-got_points(k{j}))) > 0.01
                %disp(j)
                %error("POINT_DIFF");
                check = -2;
                break;
            end
        end
    end
    
    if check == 1
        type(1) = type(1)+1;
        if angles('C') >= pi/2
            angle_type(1, 1) = angle_type(1, 1)+1;
        end
        if angles('D') >= pi/2
            angle_type(1, 2) = angle_type(1, 2)+1;
        end
        if angles('E') >= pi/2
            angle_type(1, 3) = angle_type(1, 3)+1;
        end
        if scenario == -1
            angle_type(1, 5) = angle_type(1, 5)+1;
        end
        continue;
    end
    
    error("!!!");
    
%     type(2) = type(2)+1;
%     if angles('C') >= pi/2
%         angle_type(2, 1) = angle_type(2, 1)+1;
%     end
%     if angles('D') >= pi/2
%         angle_type(2, 2) = angle_type(2, 2)+1;
%     end
%     if angles('E') >= pi/2
%         angle_type(2, 3) = angle_type(2, 3)+1;
%     end
%     if scenario == -1
%         angle_type(2, 5) = angle_type(2, 5)+1;
%     end
%     
%     [got_angles, got_points] = IK(f(1), f(2), f(3), angles('T'), theta_y, z0, -1, arms_lengths);
%     
%     k = keys(got_angles);
%     v = values(got_angles);
%     
%     for j=1:length(got_angles)
%         
%         if abs(mod(got_angles(k{j}), pi)-mod(angles(k{j}), pi)) > 0.01
%             txt = [got_angles(k{j}), angles(k{j})]; 
%             %disp(txt);
%             txt_angles = [angles('C'), angles('D'), angles('E'), angles('T'), z0];
%             disp(txt_angles);
%             error("ANGLE_DIFF");
%             break;
%         end
%         
%         if k{j} ~= 'T'
%             if max(abs(points(k{j})-got_points(k{j}))) > 0.01
%                 %disp(j)
%                 error("POINT_DIFF");
%             end
%         end
%     end
end

disp("DONE");
txt = [type(1), angle_type(1, :); type(2), angle_type(2, :)];
%Number per IK type, <C, <D, <E, <T, scenario
disp(txt);

%% Bugs
