function[points] = FK(angles, z0)
    arms_lengths = containers.Map();
    arms_lengths('AB') = z0;
    arms_lengths('BC') = 3;
    arms_lengths('CD') = 4;
    arms_lengths('DE') = 5;
    arms_lengths('EF') = 6;

    points = containers.Map();
    points('A') = [0, 0, 0];
    points('B') = [0, 0, z0];
    points('C') = [arms_lengths('BC'), 0, z0];
    points('D') = [arms_lengths('CD')*cos(angles('C'))+arms_lengths('BC'), sin(angles('C'))*arms_lengths('CD')*cos(angles('T')), arms_lengths('CD')*sin(angles('C'))*sin(angles('T'))+z0];

    arms_lengths('CE') = cosine_law_side(arms_lengths('CD'), arms_lengths('DE'), pi-angles('D'));
    angles('temp1') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'));
    points('E') = [arms_lengths('CE')*cos(angles('temp1'))+arms_lengths('BC'), arms_lengths('CE')*sin(angles('temp1'))*cos(angles('T')), arms_lengths('CE')*sin(angles('temp1'))*sin(angles('T'))+z0];

    arms_lengths('CF') = cosine_law_side(arms_lengths('CE'), arms_lengths('EF'), pi-angles('E')-cosine_law_angle(arms_lengths('CE'), arms_lengths('DE'), arms_lengths('CD')));
    angles('temp2') = angles('C')-cosine_law_angle(arms_lengths('CD'), arms_lengths('CE'), arms_lengths('DE'))-cosine_law_angle(arms_lengths('CE'), arms_lengths('CF'), arms_lengths('EF'));
    points('F') = [arms_lengths('CF')*cos(angles('temp2'))+arms_lengths('BC'), arms_lengths('CF')*sin(angles('temp2'))*cos(angles('T')), arms_lengths('CF')*sin(angles('temp2'))*sin(angles('T'))+z0];
end