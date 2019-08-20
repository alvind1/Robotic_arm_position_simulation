function[] = plot_real_board()
    [x0, y0, z0, w, board_theta, holez, min_axis, maj_axis, tri_height, ~, ~, ~] = get_real_boardhole_coords(); 
    
    %BOARD
    rx(1:4) = [x0-sin(board_theta)*w, x0+sin(board_theta)*w, x0+sin(board_theta)*w, x0-sin(board_theta)*w];
    ry = [w*cos(board_theta), -w*cos(board_theta), -w*cos(board_theta), w*cos(board_theta)];
    rz = [0, 0, z0, z0];
    pr = patch(rx, ry, rz, 'Blue');
    pr.FaceAlpha = 0.3;
    
    %Triangle %Specify left or right
    tx = [rx(3:4), rx(4)]; %Change last tx for other direction;
    ty = [ry(3:4), ry(4)];
    tz = [rz(3:4), rz(4)+tri_height];
    pt = patch(tx, ty, tz, 'Blue');
    pt.FaceAlpha = 0.3;
    
    %HOLE TODO: Change to ellipse
    min_axis = min_axis/2;
    maj_axis = maj_axis/2;
    
    t = linspace(0, 2*pi);
    cx(1:100) = x0-maj_axis*cos(t)*sin(board_theta);
    cy = y0+maj_axis*cos(t)*cos(board_theta);
    cz = holez + min_axis*sin(t);
    patch(cx, cy, cz, 'Green');
    
    %LIMITING PLANE %FIXME make it adjustable for approaching on angle
    px(1:4) = [x0+3.5, x0+3.5, x0+3.5, x0+3.5];
    py(1:4) = [-100, 100, 100, -100];
    pz(1:4) = [0, 0, 100, 100];
    pp = patch(px, py, pz, 'Black');
    
    plot_rivets(x0, y0, 3, board_theta);

    view(3);

    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    hold on;
end 

%Add triangle