function[check] = IK_conditions(points, arms_lengths, num)
    check = 1;
    if(norm(points('F')-points('C')) > arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF'))
        check = -1;
        %disp("A.1");
        return;
    end 

    if(triangle_inequality(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))==-1)
        check = -2;
        %disp("A.2");
        return;
    end 
    
    if num == 1
        got_val = values(points);
        k = keys(points);

        for j = 2:length(k) %Checks if arm segments overlap
            for m = j+1:length(k)
                check = check_line_intersection(got_val{j-1}, got_val{j}, got_val{m-1}, got_val{m});
                if check == -3
                    %disp("B.1");
                    return;
                end
            end
        end
       
        v = values(points);
    
        for i=1:length(v) %Checks if x or z components are negative
            temp = v{i};
            %disp(points(k{i}));
            if(temp(1) < -0.01 || temp(3) < -0.01)
                %disp("B.2");
                check = -4;
                return;
            end
        end
    end
end