function[rotate_angles] = get_rotation_angles(temp)
    rotate_angles = containers.Map();
   
   if temp(1) == 0
       if temp(2) >= 0
           rotate_angles('Z') = pi/2;
       else
           rotate_angles('Z') = -pi/2;
       end
   else
       rotate_angles('Z') = abs(atan(temp(2)/temp(1)));
       if temp(1) < 0 && temp(2) > 0 
            rotate_angles('Z') = pi-rotate_angles('Z');
       elseif temp(1) < 0 && temp(2) < 0
            rotate_angles('Z') = -pi+rotate_angles('Z');
       elseif temp(1) > 0 && temp(2) < 0
            rotate_angles('Z') = -rotate_angles('Z');
       end
   end
   
   if temp(1) == 0
       if temp(3) >= 0
           rotate_angles('Y') = pi/2;
       else
           rotate_angles('Y') = -pi/2;
       end
   else
       rotate_angles('Y') = abs(atan(temp(3)/temp(1)));
       if temp(1) < 0 && temp(2) > 0 
            rotate_angles('Y') = pi-rotate_angles('Y');
       elseif temp(1) < 0 && temp(2) < 0
            rotate_angles('Y') = -pi+rotate_angles('Y');
       elseif temp(1) > 0 && temp(2) < 0
            rotate_angles('Y') = -rotate_angles('Y');
       end
   end
   
   if temp(3) == 0
       if temp(2) >= 0
           rotate_angles('X') = pi/2;
       else
           rotate_angles('X') = -pi/2;
       end
   else
       rotate_angles('X') = abs(atan(temp(2)/temp(3)));
       if temp(3) < 0 && temp(2) > 0 
            rotate_angles('X') = pi-rotate_angles('X');
       elseif temp(3) < 0 && temp(2) < 0
            rotate_angles('X') = -pi+rotate_angles('X');
       elseif temp(3) > 0 && temp(2) < 0
            rotate_angles('X') = -rotate_angles('X');
       end
   end
   
end

%     if b(2) == 0
%         if b(3) > 0
%             rotate_angles('X') = pi/2;
%         else
%             rotate_angles('X') = -pi/2;
%         end
%     else
%         rotate_angles('X') = abs(atan((b(3)-z0)/b(2)));
%         if b(3) <= z0 && b(2) > 0
%             rotate_angles('X') = -rotate_angles('X');
%         elseif b(3) <= z0 && b(2) < 0
%             rotate_angles('X') = -pi+rotate_angles('X');
%         elseif b(3) > z0 && b(2) < 0
%             rotate_angles('X') = pi-rotate_angles('X');
%         end
%     end
%     
%     
%     if b(1)-x0 == 0
%         if b(3) > 0
%             rotate_angles('Y') = pi/2;
%         else
%             rotate_angles('Y') = -pi/2;
%         end
%         
%     else
%         rotate_angles('Y') = abs(atan((b(3)-z0)/(b(1)-x0)));
%         if b(1) < x0 && b(3) > 0
%             rotate_angles('Y') = pi-rotate_angles('Y');
%         elseif b(1) < x0 && b(3) < 0
%             rotate_angles('Y') = -pi+rotate_angles('Y');
%         elseif b(1) > x0 && b(3) < 0
%             rotate_angles('Y') = -rotate_angles('Y');
%         end
%     end
%        
%             
%     if b(1)-x0 == 0 %Not entirely sure
%         if b(1) > x0
%             rotate_angles('Z') = pi/2;
%         else
%             rotate_angles('Z') = -pi/2;
%         end
%     else
%         rotate_angles('Z') = abs(atan(b(2)/(b(1)-x0)));
%         if b(1) < x0 && b(2) > 0
%             rotate_angles('Z') = pi-rotate_angles('Z');
%         elseif b(1) < x0 && b(2) < 0
%             rotate_angles('Z') = -pi+rotate_angles('Z');
%         elseif b(1) > x0 && b(2) < 0
%             rotate_angles('Z') = -rotate_angles('Z');
%         end
%     end