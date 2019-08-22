function[] = set_real_arms_lengths(z0)
    global  arms_lengths; %In inches
    arms_lengths = containers.Map();
    arms_lengths('AB') = z0;
    arms_lengths('BC') = 25.125+5; %Actual lengths
    arms_lengths('CD') = 5;
    arms_lengths('DE') = 5;
    arms_lengths('EF') = 7;
end