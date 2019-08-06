function[check] = check_segmentboard_intersection(plane, ppoint, lpoint, v, board, holer)

    a = plane(1);
    b = plane(2);
    c = plane(3);
        
    syms t;
    eqn = a*(lpoint(1)+v(1)*t-ppoint(1))+b*(lpoint(2)+v(2)*t-ppoint(2))+c*(lpoint(3)+v(3)*t-ppoint(3)) == 0;
    solt = solve(eqn, t);
    
    if isempty(solt)
        check = 1;
    elseif solt < 0 || solt > 1
        check = 1;
    else
        p = lpoint+v*double(solt);
        
        if p(3) > board(3) || p(3) < 0
            check = 1;
        elseif p(2) > board(2) || p(2) < -board(2)
            check = 1;
        elseif p(1) > ppoint(1)+board(1) || p(1) < ppoint(1)-board(1)
            check = 1;
        elseif norm(p-ppoint) <= holer
            check = 1;
        else
            check = -1;
        end
    end
end