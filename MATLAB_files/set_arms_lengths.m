function[] = set_arms_lengths(z0)
    global  arms_lengths; %In inches
    arms_lengths = containers.Map();
    arms_lengths('AB') = z0;
    arms_lengths('BC') = 5; %Testing lengths
    arms_lengths('CD') = 6;
    arms_lengths('DE') = 7;
    arms_lengths('EF') = 8;
end