function[] = get_ax_dim()
    global ax arms_lengths;
    xmin = -10;
    xmax = arms_lengths('BC')+arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF');
    ymin = -10;
    ymax = arms_lengths('BC')+arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF');
    zmin = 0;
    zmax = arms_lengths('BC')+arms_lengths('CD')+arms_lengths('DE')+arms_lengths('EF');
    ax = ([xmin, xmax, ymin, ymax, zmin, zmax]);
end