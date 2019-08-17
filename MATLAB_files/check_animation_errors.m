function[] = check_animation_errors(angles, points, temp_z0, it, k)   
    global arms_lengths;

    %%
    if ismissing(points(k{it}))
        txt = [angles('C'), angles('D'), angles('E'), angles('T'), temp_z0, it];
        disp(txt);
        txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
        disp(txt);
        error("A");
    end

    if it ~= 6 && abs(norm(points(k{it})-points(k{it+1}))-arms_lengths(strcat(k{it}, k{it+1}))) > 0.1
        error("ARM LENGTH OFF");
    end

    if it ~= 6 && check_segmentboard_intersection(points(k{it}), points(k{it+1})-points(k{it})) == -1
        txt = [points(k{it}), "B", points(k{it+1})-points(k{it}), "B", it, k{it+1}];
        disp(txt);
        txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
        disp(txt);
        disp("BOARD INTERSECTION");
    end

end
