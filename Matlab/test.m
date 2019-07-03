xlim([0, 10]);
ylim([-5, 5]);
zlim([0, 10]);
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
hold on;

r = 1

for i=1:1000
    n = linspace(0, 10);
    x = r*cos(n)+3;
    y = r*sin(n)+3;
    line(x, y);
    
    hold on;
    
    x_val = [0, r*cos(i)+3];
    y_val = [0, r*sin(i)+3];
    plot(x_val, y_val);
    pause(0.1);
    
    axis;
    
    hold off;
    
    drawnow;
end 