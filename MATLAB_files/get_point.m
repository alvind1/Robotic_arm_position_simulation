function[temp_point, temp_z0] = get_point(j, n, start_point, end_point, start_z0, z0)
    v = end_point-start_point;
    v = j*v/n;
    temp_point = start_point+v;
    temp_z0 = (z0-start_z0)*j/n+start_z0;
end