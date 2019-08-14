function[] = animate_by_point(start_point, start_theta_x, start_theta_y, end_point, end_theta_x, end_theta_y, p, n)
    %% Constants
    grid on;
    axis manual;
    
    global arms_lengths ax;

    [cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords();
    plot_board(cx, cy, cz, w, board_theta, holez, r);

    hold on;
    
    start_z0 = get_z0(start_point, start_theta_x, start_theta_y);
    end_z0 = get_z0(end_point, end_theta_x, end_theta_y);
    
    temp_theta_y = start_theta_y;

    %%
    for j = 0:n
        [temp_point] = get_point(j, n, start_point, end_point);
        [temp_z0] = get_z0(temp_point, start_theta_x);
        [temp_theta_y] = get_theta_y(temp_theta_y, start_theta_x, temp_z0, temp_point);
        %txt = [temp_angles('C'), temp_angles('D'), temp_angles('E'), temp_angles('T')];
        %disp(txt);
        [temp_angles, points] = IK(temp_point(1), temp_point(2), temp_point(3), start_theta_x, temp_theta_y, temp_z0, 1);

        x_val = [];
        y_val = [];
        z_val = [];

        k = keys(points);
        val = values(points);
        length_val = values(arms_lengths);

        for i = 1:length(points)
            check_animation_errors(temp_angles, points, temp_z0, i, k);

            x_val(end+1) = val{i}(1);
            y_val(end+1) = val{i}(2);
            z_val(end+1) = val{i}(3);
            splt(i) = scatter3(x_val, y_val, z_val); %Draw

            if(i ~= 1) %Print lengths
                tplt(1, i) = text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
            end

            if(i ~= 1 && i ~= 2 && i ~= 6)
                tplt(2,  i) = text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(temp_angles(k{i})), 'Color', 'r');
            end 

            if (i == 3)
                txt = ["Plane rotation", num2str(temp_angles('T'))];
                tplt(3, i) = text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt, 'Color', 'black');
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
             delete(tplt);
         end
    end

    disp("DONE");
end