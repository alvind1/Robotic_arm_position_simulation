function[start_angles, start_z0] = get_starting_angles()
    start_angles = containers.Map();
    start_angles('C') = 2.5;
    start_angles('D') = -2.0933;
    start_angles('E') = -0.2;
    start_angles('T') = 1.4461;
    start_z0 = 9.9067;
end