function[temp_point] = get_point(j, n, start_point, end_point)
    v = end_point-start_point;
    v = j*v/n;
    temp_point = start_point+v;
end