function[] = animate_func(temp_angles, points, temp_z0, j, p, n)
    %%
    global ax;
    
    grid on;
    hold on;
    
    k = keys(points);
    val = values(points);
    
    x_val = zeros(1, 6);
    y_val = zeros(1, 6);
    z_val = zeros(1, 6);
    splt = zeros(1, 6);
    tplt = zeros(3, 6);

    for i = 1:length(points)
        check_animation_errors(temp_angles, points, temp_z0, i, k);

        x_val(i) = val{i}(1);
        y_val(i) = val{i}(2);
        z_val(i) = val{i}(3);
        splt(i) = scatter3(x_val, y_val, z_val); %Draw

        if(i ~= 1) %Print lengths
            %tplt(1, i) = text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
        end

        if(i ~= 1 && i ~= 2 && i ~= 6) %Print angles
            %tplt(2,  i) = text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(temp_angles(k{i})), 'Color', 'r');
        end 

        if (i == 3)
            txt = ["Plane rotation", num2str(temp_angles('T'))];
            %tplt(3, i) = text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt, 'Color', 'black');
        end 

    end

    plt = plot3(x_val, y_val, z_val); %Draw
    axis(ax);

    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    drawnow;
    
     if j ~= n || (p == 0 && j == n)
         delete(plt);
         delete(splt);
         %delete(tplt);
     end
end