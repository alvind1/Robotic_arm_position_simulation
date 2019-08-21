function[] = set_arms_lengths(z0)
    global  arms_lengths; %In inches
    arms_lengths = containers.Map();
    arms_lengths('AB') = z0;
    arms_lengths('BC') = 9; %Testing lengths
    arms_lengths('CD') = 4;
    arms_lengths('DE') = 4;
    arms_lengths('EF') = 3;
end