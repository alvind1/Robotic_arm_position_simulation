function[check] = IK_conditions(points, arms_lengths)
    check = 1;
    if(norm(points('F')-points('C')) > arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF'))
        check = -1;
    end 

    if(triangle_inequality(arms_lengths('CD'), arms_lengths('DE'), arms_lengths('CE'))==-1)
        check = -2;
    end 
end