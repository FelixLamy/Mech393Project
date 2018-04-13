function VB = O1_BM(x,G1_pos,L,G1_F,ROY,ROZ,RLY,RLZ)

    if x>=0 && x<G1_pos
       VT = ROY;
       MZ = abs(ROY)*x;
       VR = ROZ;
       MY = -abs(ROZ)*x;
    elseif x>=G1_pos && x<L
       VT = ROY+G1_F(2);
       MZ = abs(ROY)*x - abs(G1_F(2))*(x - G1_pos);
       VR = ROZ+G1_F(3);
       MY = -abs(ROZ)*x + abs(G1_F(3))*(x - G1_pos);
    else
       VT = ROY+G1_F(2);
       MZ = abs(ROY)*x - abs(G1_F(2))*(x - G1_pos);
       VR = ROZ+G1_F(3);
       MY = -abs(ROZ)*x+ abs(G1_F(3))*(x - G1_pos);
    end
    
    VB = [VT VR; MZ MY];    
       
end
