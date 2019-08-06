function[] = plot_board(points)
    x0 = 13;
    y0 = 0;
    z0 = 15;
    w = 3;
    theta = 0;
    
    rx(1:4) = [x0-sin(theta)*w, x0+sin(theta)*w, x0+sin(theta)*w, x0-sin(theta)*w];
    ry = [w*cos(theta), -w*cos(theta), -w*cos(theta), w*cos(theta)];
    rz = [0, 0, z0, z0];
    pr = patch(rx, ry, rz, 'Blue');
    pr.FaceAlpha = 0.3;
    
    t = linspace(0, 2*pi);
    r = 2;
    holez = 10;
    cx(1:100) = x0-r*cos(t)*sin(theta);
    cy = y0+r*cos(t)*cos(theta);
    cz = r*sin(t)+holez;
    patch(cx, cy, cz, 'Green'); 
    %pc.FaceAlpha = 0.3;
    
    plot_rivets(x0, y0, 3, theta);
    
    plane = [1*cos(theta), 1*sin(theta), 0];
    ppoint = [x0, y0, holez];
    board = [abs(sin(theta)*w), abs(w*cos(theta)), z0];
    
    k = keys(points);
    
    for i = 2:length(points)
        check = check_segmentboard_intersection(plane, ppoint, points(k{i-1}), points(k{i})-points(k{i-1}), board, r);
        if check == -1
            disp("ERROR");
            return;
        end
    end
   
    view(3);
    
    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
end 