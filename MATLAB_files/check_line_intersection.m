function [check] = check_line_intersection(pointA, pointB, pointC, pointD)
    tempA = pointA-pointB;
    tempB = pointD-pointC;

     syms p q;
     eqn1 = p*tempA(1)+q*tempB(1) == pointD(1)-pointB(1);
     eqn2 = p*tempA(2)+q*tempB(2) == pointD(2)-pointB(2);
     %eqn3 = p*temp1(3)-q*temp2(3) == temp2(3)-temp1(3);
     [A, B] = equationsToMatrix([eqn1, eqn2], [p, q]);

     sv = linsolve(A, B);
     if sv(1) <= 0 || sv(1) >= 1 || sv(2) <= 0 || sv(2) >= 1
         check = 1;
     else
         check = -1;
     end  
end