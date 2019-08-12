function[arms_lengths] = set_arms_lengths(z0)
    global  arms_lengths; 
    arms_lengths = containers.Map();
    arms_lengths('AB') = z0;
    arms_lengths('BC') = 3;
    arms_lengths('CD') = 4;
    arms_lengths('DE') = 5;
    arms_lengths('EF') = 6;
end