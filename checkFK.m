function[check] = checkFK(points, angles, arms_lengths)
    check = 1;
    k = keys(points);
    v_points = values(points);
    v_lengths = values(arms_lengths);
    v_angles = values(angles);
    
    for i = 1:length(points)
        if (i~=1)
            if(abs(norm(v_points{i}-v_points{i-1}) - v_lengths{i-1}) > 0.01)               
                disp(norm(v_points{i}-v_points{i-1}));
                disp(v_lengths{i-1});
                check = -1;
                error("LENGTH ERROR");
            end
        end
        
        if (i==3 || i==4 || i==5)
            if abs((pi-cosine_law_angle(v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1}))) - v_angles{i-2}) > 0.01
                txt = [k(i), v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1}), (pi-cosine_law_angle(v_lengths{i-1}, v_lengths{i}, norm(v_points{i+1}-v_points{i-1}))), v_angles{i-2}];
                disp(txt);
                txt_angles = [points('C'), points('D'), points('E'), points('F')];
                disp(txt_angles);
                error("ANGLE ERROR");
                check = -1;
            end
        end
                   
    end
    
    %disp("DONE");
end