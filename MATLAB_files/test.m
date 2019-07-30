arms_lengths = containers.Map();
arms_lengths('AB') = 1.8167;
arms_lengths('BC') = 3;
arms_lengths('CD') = 4;
arms_lengths('DE') = 5;
arms_lengths('EF') = 6;

[angles, points] = IK(6.6891, 1.2125, 4.0883, 1.0805, 1.2288, 1.8167, 1, arms_lengths);
txt = [points('A'); points('B'); points('C'); points('D'); points('E'); points('F')];
disp(txt);