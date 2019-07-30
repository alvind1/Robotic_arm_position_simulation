function[check] = IK_conditions(points, arms_lengths)
    check = 1;
    if(norm(points('F')-points('C')) > arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF'))
        check = -1;
        return;
    end 

    if(triangle_inequality(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))==-1)
        check = -2;
        return;
    end 
    
    got_val = values(points);
    k = keys(points);
    
    for j = 2:length(k) %Checks if arm segments overlap
        for m = j+1:length(k)
            check = check_line_intersection(got_val{j-1}, got_val{j}, got_val{m-1}, got_val{m});
            if check == -3
                return;
            end
        end
    end
end