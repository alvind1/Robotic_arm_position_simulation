function[] = plot_points(points, angles, words)
    global ax;
    x_val = [];
    y_val = [];
    z_val = [];
    
    k = keys(points);
    val = values(points); 
    
    for i = 1:length(points)
        x_val(end+1) = val{i}(1);
        y_val(end+1) = val{i}(2);
        z_val(end+1) = val{i}(3);
        scatter3(val{i}(1), val{i}(2), val{i}(3));
        text(val{i}(1), val{i}(2), val{i}(3), k(i));

        if(i ~= 1) %Print lengths
            text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
        end

        if(i ~= 1 && i ~= 2 && i ~= 6 && angles ~= -100)
            text(val{i}(1)+0.5, val{i}(2)+0.5, val{i}(3)+0.5, num2str(angles(k{i})), 'Color', 'r');
        end 

        if (i == 3 && angles ~= -100)
            txt = ["Plane rotation", num2str(angles('T'))];
            text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-1, txt);
        end 

        hold on;
    end

    plot3(x_val, y_val, z_val);
    axis(ax);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title(words);
end