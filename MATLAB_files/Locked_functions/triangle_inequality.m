function [bool] = triangle_inequality(a, b, c)
    if(a>=b && a>=c)
        if a <= b+c + 0.05 
            bool = 1;
        else
            bool = -1;
        end
    elseif b>=c && b>=a
        if b <= a+c + 0.05
            bool = 1;
        else
            bool = -1;
        end
    else
        if c <= a+b + 0.05
            bool = 1;
        else 
            bool = -1;
        end
    end 
end 