function[] = animate_by_angle(start_angles, end_angles, start_z0, z0, p, n)
    %% Constants
    grid on;
    axis manual;
    
    global arms_lengths ax;

    [cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords();
    plot_board(cx, cy, cz, w, board_theta, holez, r);

    hold on;

    %%
    for j = 0:n
        [temp_angles, temp_z0] = get_angles_naive(j, n, end_angles, start_angles, z0, start_z0);
        %txt = [temp_angles('C'), temp_angles('D'), temp_angles('E'), temp_angles('T')];
        %disp(txt);
        [points, ~] = FK(temp_angles, temp_z0);

        x_val = [];
        y_val = [];
        z_val = [];

        k = keys(points);
        val = values(points);
        length_val = values(arms_lengths);

        for i = 1:length(points)
            if ismissing(points(k{i}))
                txt = [temp_angles('C'), temp_angles('D'), temp_angles('E'), temp_angles('T'), temp_z0, i];
                disp(txt);
                txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
                disp(txt);
                error("A");
            end

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

            if(abs(arms_lengths('EF')-norm(points('F')-points('E'))) > 0.1)
                error("EF OFF");
            end 

            if(abs(norm(points('E')-points('D'))-arms_lengths('DE')) > 0.1)
                error("DE OFF");
            end 

            if i ~= 6 && check_segmentboard_intersection(plane, ppoint, points(k{i}), points(k{i+1})-points(k{i}), board, r) == -1
                txt = [points(k{i}), "B", points(k{i+1})-points(k{i}), "B", i, k{i+1}];
                disp(txt);
                txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
                disp(txt);
                disp("BOARD INTERSECTION");
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