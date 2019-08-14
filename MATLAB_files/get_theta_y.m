function[temp_theta_y] = get_theta_y(cur_theta_y, theta_x, temp_z0, pointF)
    global arms_lengths;
    pointC = [arms_lengths('BC'), 0, temp_z0];
    lengthCF = norm(pointF-pointC);
    lengthCE = arms_lengths('CD')+arms_lengths('DE');
    lengthEF = arms_lengths('EF');
    temp_theta_y = cosine_law_angle(lengthCF, lengthEF, lengthCE)-abs(acos((pointF(1)-pointC(1))/lengthCF));
    if cur_theta_y < temp_theta_y
        temp_theta_y = cur_theta_y;
    end
end