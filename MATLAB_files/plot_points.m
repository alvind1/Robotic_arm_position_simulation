function[] = plot_points(points, rad_angles, words)
    global ax;

    k = keys(points);
    val = values(points); 
    deg_angles = containers.Map();
    
    x_val = zeros(1, 6);
    y_val = zeros(1, 6);
    z_val = zeros(1, 6);
    
    for i = 1:length(points)
        x_val(i) = val{i}(1);
        y_val(i) = val{i}(2);
        z_val(i) = val{i}(3);
        scatter3(val{i}(1), val{i}(2), val{i}(3));
        text(val{i}(1), val{i}(2), val{i}(3), k(i));

        if(i ~= 1) %Print lengths
            text((val{i}(1)+val{i-1}(1))/2, (val{i}(2)+val{i-1}(2))/2, (val{i}(3)+val{i-1}(3))/2, num2str(norm(points(k{i})-points(k{i-1}))));
        end

        if(i ~= 1 && i ~= 2 && i ~= 6 && deg_angles ~= -100)
            deg_angles(k{i}) = rad_angles(k{i})*180/pi;
            %text(val{i}(1)-0.5, val{i}(2)-0.5, val{i}(3)-0.5, num2str(deg_angles(k{i})), 'Color', 'r');
        end 

        if (i == 3 && deg_angles ~= -100)
            deg_angles('T') = rad_angles('T')*180/pi;
            txt = ["", num2str(deg_angles('T'))];
            text(val{i}(1)-1, val{i}(2)-1, val{i}(3)-3, txt);
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