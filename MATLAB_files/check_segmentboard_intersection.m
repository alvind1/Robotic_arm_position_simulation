function[check] = check_segmentboard_intersection(lpoint, v, it)
    global real_scenario;
    
    if real_scenario == 0
        [~, ~, ~, ~, ~, ~, r, plane, ppoint, board] = get_board_coords();
        min_axis = r;
        maj_axis = r;
    else
        [~, ~, ~, ~, ~, ~, min_axis, maj_axis, tri_h, plane, ppoint, board] = get_real_board_coords();
    end
    
    safety_net = 0.1;
    
    a = plane(1);
    b = plane(2);
    c = plane(3);
        
    t = (a*(ppoint(1)-lpoint(1))+b*(ppoint(2)-lpoint(2))+c*(ppoint(3)-lpoint(3)))/(a*v(1)+b*v(2)+c*v(3));
    
    if t == Inf || isnan(t)
        check = 1;
    elseif t < 0-safety_net || t > 1+safety_net
        check = 1;
    else
        p = lpoint+v*t;
        
        if p(3) >= board(3) -safety_net && p(3) <= board(3)+tri_h+safety_net && p(2) <= board(2)+safety_net && p(2) >= -board(2)-safety_net
            y_dist = abs(p(2)-board(2));
            if p(3)-board(3) <= -y_dist*3.5/19.102 + 3.5
                check = -1;
                return;
            end
        end
        
        if p(3) > board(3)+safety_net || p(3) < 0-safety_net
            check = 1;
        elseif p(2) > board(2)+safety_net || p(2) < -board(2)-safety_net
            check = 1;
        elseif p(1) > ppoint(1)+board(1)+safety_net || p(1) < ppoint(1)-board(1)-safety_net
            check = 1;
        elseif (p(2)-ppoint(2))^2/(maj_axis/2)^2 + (p(3)-ppoint(3))^2/(min_axis/2)^2 <= 1
            check = 1;
        else
            %disp(ppoint);
            check = -1;
            %txt = [t, (a*(ppoint(1)-lpoint(1))+b*(ppoint(2)-lpoint(2))+c*(ppoint(3)-lpoint(3))), (a*v(1)+b*v(2)+c*v(3)), "A", plane, "A", ppoint, "A", lpoint, "A", v];
            %disp(txt);
        end
    end
end