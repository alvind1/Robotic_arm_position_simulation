function[points, scenario] = FK(angles, z0, arms_lengths)
    points = containers.Map();
    points('A') = [0, 0, 0];
    points('B') = [0, 0, z0];
    points('C') = [arms_lengths('BC'), 0, z0];
    points('D') = [arms_lengths('CD')*cos(angles('C'))+arms_lengths('BC'), sin(angles('C'))*arms_lengths('CD')*cos(angles('T')), arms_lengths('CD')*sin(angles('C'))*sin(angles('T'))+z0];
    scenario = 0;
    
    arms_lengths('CE') = cosine_law_side(arms_lengths('CD'), arms_lengths('DE'), pi-angles('D'));
    angles('temp1') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'));
    points('E') = [arms_lengths('CE')*cos(angles('temp1'))+arms_lengths('BC'), arms_lengths('CE')*sin(angles('temp1'))*cos(angles('T')), arms_lengths('CE')*sin(angles('temp1'))*sin(angles('T'))+z0];

    if angles('E')+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) < pi
        temp3_angle =  pi-angles('E')-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD'));
        scenario = 1;
    else
        temp3_angle = angles('E')+cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')) - pi;
        scenario = -1;
    end
    
    arms_lengths('CF') = cosine_law_side(arms_lengths('CE'), arms_lengths('EF'), temp3_angle);
    if scenario == 1
        angles('temp2') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
    elseif scenario == -1
        angles('temp2') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))+cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
    end
    txt = ["temp2", angles('C'), angles('temp2')];
    points('F') = [arms_lengths('CF')*cos(angles('temp2'))+arms_lengths('BC'), arms_lengths('CF')*sin(angles('temp2'))*cos(angles('T')), arms_lengths('CF')*sin(angles('temp2'))*sin(angles('T'))+z0];
end