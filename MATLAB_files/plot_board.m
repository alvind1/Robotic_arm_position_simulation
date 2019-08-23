function[] = plot_board()
    [x0, y0, z0, w, board_theta, holez, r, ~, ~, ~] = get_board_coords(); 
    
    %BOARD
    rx(1:4) = [x0-sin(board_theta)*w, x0+sin(board_theta)*w, x0+sin(board_theta)*w, x0-sin(board_theta)*w];
    ry = [w*cos(board_theta), -w*cos(board_theta), -w*cos(board_theta), w*cos(board_theta)];
    rz = [0, 0, z0, z0];
    pr = patch(rx, ry, rz, 'Blue');
    pr.FaceAlpha = 0.3;
    
    %HOLE TODO: Change to ellipse
    t = linspace(0, 2*pi);
    cx(1:100) = x0-r*cos(t)*sin(board_theta);
    cy = y0+r*cos(t)*cos(board_theta);
    cz = r*sin(t)+holez;
    patch(cx, cy, cz, 'Green'); 
    %pc.FaceAlpha = 0.3;

    plot_rivets(x0, y0, 3, board_theta);

    view(3);

    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    hold on;
end 
