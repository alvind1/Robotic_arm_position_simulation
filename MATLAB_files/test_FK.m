angles = containers.Map();
arms_lengths = containers.Map();
arms_lengths('AB') = 0;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;
mx = 0;

for i = 1:10000
    z0 = 8*rand(1, 1)+2;
    angles('C') = -(pi)*rand(1, 1);
    angles('D') = -(pi)*rand(1, 1);
    angles('E') = -(pi)*rand(1, 1);
    angles('T') = (pi)*rand(1, 1);
    
    arms_lengths('AB') = z0;
    
    points = FK(angles, z0, arms_lengths);
    temp_lengths = containers.Map(arms_lengths.keys, arms_lengths.values);
    remove(temp_lengths, 'CE'); 
    remove(temp_lengths, 'CF');
    
    check = checkFK(points, angles, temp_lengths);
    
    f = points('F');
    if abs(f(3)-z0-f(2)*tan(angles('T'))) > mx
        mx = abs(f(3)-z0-f(2)*tan(angles('T')));
    end 
    
    if check == -1
        disp(i);
        error("!!!");
    end
end
    
disp("DONE");

%% BUGS
