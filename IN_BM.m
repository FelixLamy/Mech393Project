function VB = IN_BM(x,P2_pos,P1_pos,L,P2_F,P1_F,ROY,ROZ,RLY,RLZ,torsion)

    if x>=0 && x<P2_pos
       VT = ROY;
       MZ = abs(ROY)*x;
       VR = ROZ;
       MY = -abs(ROZ)*x;
       T = torsion(1);
    elseif x>=P2_pos && x<P1_pos
       VT = ROY+P2_F(2);
       MZ = abs(ROY)*x - abs(P2_F(2))*(x - P2_pos);
       VR = ROZ+P2_F(3);
       MY = -abs(ROZ)*x+ abs(P2_F(3))*(x - P2_pos);
       T = torsion(2);
    elseif x>=P1_pos && x<L
       VT = ROY+P2_F(2)+P1_F(2);
       MZ = abs(ROY)*x - abs(P2_F(2))*(x - P2_pos) + abs(P1_F(2))*(x - P1_pos);
       VR = ROZ + P2_F(3) + P1_F(3);
       MY = -abs(ROZ)*x+ abs(P2_F(3))*(x - P2_pos) - abs(P1_F(3))*(x - P1_pos);
       T = torsion(3);
    else
       VT = ROY+P2_F(2)+P1_F(2)+RLY;
       MZ = abs(ROY)*x - abs(P2_F(2))*(x - P2_pos) + abs(P1_F(2))*(x - P1_pos);
       VR = ROZ + P2_F(3) + P1_F(3) + RLZ;
       MY = -abs(ROZ)*x+ abs(P2_F(3))*(x - P2_pos) - abs(P1_F(3))*(x - P1_pos);
       T = torsion(3);
    end
    
    VB = [VT VR; MZ MY;T 0];    
       
end
