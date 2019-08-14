function[] = move_z0(points, new_z0, z0, theta_x, theta_y, p, n)
    end_pointF = [pointF(1), pointF(2), pointF(3)-(z0-new_z0)];
    animate_by_point(pointF, theta_x, theta_y, end_pointF, theta_x, theta_y, p, n);
    points('F') = [pointF(1), pointF(2), pointF(3)-(z0-new_z0)];
end