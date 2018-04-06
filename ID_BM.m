function VB = ID_BM(x,G2_pos,P3_pos,L,G2_F,P3_F,ROY,ROZ,RLY,RLZ,torsion)

%     if x>=0 && x<G2_pos
%        VT = ROY;
%        MZ = abs(ROY)*x;
%        VR = ROZ;
%        MY = -abs(ROZ)*x;
%        T = torsion(1);
%     elseif x>=G2_pos && x<P3_pos
%        VT = ROY+G2_F(2);
%        MZ = abs(ROY)*x + abs(G2_F(2))*(x - P3_pos);
%        VR = ROZ+G2_F(3);
%        MY = -abs(ROZ)*x + abs(G2_F(3))*(x - P3_pos);
%        T = torsion(2);
%     elseif x>=P3_pos && x<L
%        VT = ROY+G2_F(2)+P3_F(2);
%        MZ = abs(ROY)*x + abs(G2_F(2))*(x - G2_pos) + abs(P3_F(2))*(x - P3_pos);
%        VR = ROZ + G2_F(3) + P3_F(3);
%        MY = -abs(ROZ)*x+ abs(G2_F(3))*(x - G2_pos) - abs(P3_F(3))*(x - P3_pos);
%        T = torsion(3);
%     else
%        VT = ROY+G2_F(2)+P3_F(2)+RLY;
%        MZ = abs(ROY)*x - abs(G2_F(2))*(x - G2_pos) + abs(P3_F(2))*(x - P3_pos);
%        VR = ROZ + G2_F(3) + P3_F(3) + RLZ;
%        MY = -abs(ROZ)*x+ abs(G2_F(3))*(x - G2_pos) - abs(P3_F(3))*(x - P3_pos);
%        T = torsion(3);
%     end

if x>=0 && x<G2_pos
       VT = ROY;
       MZ = -abs(ROY)*x;
       VR = ROZ;
       MY = -abs(ROZ)*x;
       T = torsion(1);
    elseif x>=G2_pos && x<P3_pos
       VT = ROY+G2_F(2);
       MZ = -abs(ROY)*x + abs(G2_F(2))*(x - G2_pos);
       VR = ROZ+G2_F(3);
       MY = -abs(ROZ)*x - abs(G2_F(3))*(x - G2_pos);
       T = torsion(2);
    elseif x>=P3_pos && x<L
       VT = ROY+G2_F(2)+P3_F(2);
       MZ = -abs(ROY)*x + abs(G2_F(2))*(x - G2_pos) + abs(P3_F(2))*(x - P3_pos);
       VR = ROZ + G2_F(3) + P3_F(3);
       MY = -abs(ROZ)*x - abs(G2_F(3))*(x - G2_pos) + abs(P3_F(3))*(x - P3_pos);
       T = torsion(3);
    else
       VT = ROY+G2_F(2)+P3_F(2)+RLY;
       MZ = -abs(ROY)*x + abs(G2_F(2))*(x - G2_pos) + abs(P3_F(2))*(x - P3_pos);
       VR = ROZ + G2_F(3) + P3_F(3) + RLZ;
       MY = -abs(ROZ)*x - abs(G2_F(3))*(x - G2_pos) + abs(P3_F(3))*(x - P3_pos);
       T = torsion(3);
    end
    
    VB = [VT VR; MZ MY;T 0];    
       
end