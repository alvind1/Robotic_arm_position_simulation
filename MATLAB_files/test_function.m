function[] = test_function(s, ax) 
    %TODO: Maken an animation function for stages
    x = [0, 0];
    y = [0, 0];
    hold off;
    for i = 0:100
       x(1) = 2*cos(s*i/100);
       y(1) = 2*sin(s*i/100);
       plot(x, y);
       axis(ax);
       pause(0.1);
    end
end