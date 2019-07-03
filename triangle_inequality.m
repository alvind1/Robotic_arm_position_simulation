function [bool] = triangle_inequality(a, b, c)
    if(a>=b && a>=c)
        if (a < b+c) 
            bool = 1;
        else
            bool = -1;
        end
    elseif b>=c && b>=a
        if b < a+c
            bool = 1;
        else
            bool = -1;
        end
    else
        if c < a+b
            bool = 1;
        else 
            bool = -1;
        end
    end 
end 