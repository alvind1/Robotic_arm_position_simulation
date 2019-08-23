function[cx, cy, cz, w, board_theta, holez, min_axis, maj_axis, triangle_h, plane, ppoint, board] = get_real_boardhole_coords()
    %REAL COORDINATES
    cx = 34; %x coord of board centre
    cy = 0; %y coord of board centre
    cz = 37.25;% z coord
    w = 19.102/2; %width
    board_theta = 0;
    holez = 24.308; %height of centre of hole
    min_axis = 9.4; % 
    maj_axis = 15;

    triangle_h = 40.75-37.25;
    
    %Minimum width of box is 3.5 inches
    
    plane = [1*cos(board_theta), 1*sin(board_theta), 0]; %Normal vector of plane
    ppoint = [cx, cy, holez]; %Centre of hole
    board = [abs(sin(board_theta)*w), abs(w*cos(board_theta)), cz]; %positive x, y, z components of one of the top corners
end