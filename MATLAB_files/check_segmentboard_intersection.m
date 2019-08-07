function[check] = check_segmentboard_intersection(plane, ppoint, lpoint, v, board, r)
    a = plane(1);
    b = plane(2);
    c = plane(3);
        
    t = (a*(ppoint(1)-lpoint(1))+b*(ppoint(2)-lpoint(2))+c*(ppoint(3)-lpoint(3)))/(a*v(1)+b*v(2)+c*v(3));
    
    if t == Inf
        check = 1;
    elseif t < 0 || t > 1
        check = 1;
    else
        p = lpoint+v*t;
        
        if p(3) > board(3) || p(3) < 0
            check = 1;
        elseif p(2) > board(2) || p(2) < -board(2)
            check = 1;
        elseif p(1) > ppoint(1)+board(1) || p(1) < ppoint(1)-board(1)
            check = 1;
        elseif norm(p-ppoint) <= r
            check = 1;
        else
            disp(ppoint);
            check = -1;
            %txt = [t, (a*(ppoint(1)-lpoint(1))+b*(ppoint(2)-lpoint(2))+c*(ppoint(3)-lpoint(3))), (a*v(1)+b*v(2)+c*v(3)), "A", plane, "A", ppoint, "A", lpoint, "A", v];
            %disp(txt);
        end
    end
end