function[cx, cy, cz, w, board_theta, holez, r, plane, ppoint, board] = get_boardhole_coords()
    cx = 10; %Board and hole coordinates
    cy = 0;
    cz = 15;
    w = 3;
    board_theta = 0;
    holez = 10;
    r = 2;
    
    plane = [1*cos(board_theta), 1*sin(board_theta), 0];
    ppoint = [cx, cy, holez];
    board = [abs(sin(board_theta)*w), abs(w*cos(board_theta)), cz];
end