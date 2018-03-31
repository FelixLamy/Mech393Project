%% Pinion 1

%Dynamic factor Kv
gearbox.pinion1.tooth_bending.tang_vel = 0.5*60*gearbox.pinion1.geometry.pitchdiameter*gearbox.pinion1.geometry.omega/12; %ft/min
gearbox.pinion1.tooth_bending.B = ((12-gearbox.pinion1.material.quality)^(2/3))/4;
gearbox.pinion1.tooth_bending.A = 50+56*(1-gearbox.pinion1.tooth_bending.B);
gearbox.pinion1.tooth_bending.Kv = (gearbox.pinion1.tooth_bending.A/(gearbox.pinion1.tooth_bending.A+sqrt(gearbox.pinion1.tooth_bending.tang_vel)))^gearbox.pinion1.tooth_bending.B;

%Load distribution factor Km
if gearbox.pinion1.geometry.facewidth<2
    gearbox.pinion1.tooth_bending.Km = 1.6;
elseif gearbox.pinion1.geometry.facewidth<=6 && gearbox.pinion1.geometry.facewidth>=2
    gearbox.pinion1.tooth_bending.Km = 1.6 + (1.7-1.6)/(6-2)*(gearbox.pinion1.geometry.facewidth-2);
elseif gearbox.pinion1.geometry.facewidth>=6 && gearbox.pinion1.geometry.facewidth<9
     gearbox.pinion1.tooth_bending.Km = 1.7 + (1.8-1.7)/(9-6)*(gearbox.pinion1.geometry.facewidth-6);
else
    gearbox.pinion1.tooth_bending.Km = 2;
end

%Application Factor Ka
gearbox.pinion1.tooth_bending.Ka = 1.25; %moderate shock application factor, uniform

%Size Factor
gearbox.pinion1.tooth_bending.Ks = 1.25; %conservative

%Rim Thickness Factor
gearbox.pinion1.tooth_bending.Kb = 1; %no rim for now

%Idler Factor
gearbox.pinion1.tooth_bending.Ki = 1; %no idler

%Bending Geometry Factor J
gearbox.pinion1.tooth_bending.J = 0.32; %from graph

%Bending Stress
gearbox.pinion1.tooth_bending.bending_stress = (gearbox.pinion1.loads.tang_F*gearbox.pinion1.geometry.diametral_pitch*gearbox.pinion1.tooth_bending.Ka*gearbox.pinion1.tooth_bending.Km*gearbox.pinion1.tooth_bending.Ks*gearbox.pinion1.tooth_bending.Kb*gearbox.pinion1.tooth_bending.Ki)/(gearbox.pinion1.geometry.facewidth*gearbox.pinion1.tooth_bending.J*gearbox.pinion1.tooth_bending.Kv);

%uncorrected fatigue strength
gearbox.pinion1.tooth_bending.uncorrected_strength = (77.3*gearbox.pinion1.material.hardness)+12800;

%Temperature Factor Kt
gearbox.pinion1.tooth_bending.Kt = 1;

%Life Factor Kl
gearbox.pinion1.tooth_bending.Kl = 1.3558*(gearbox.cycles)^(-0.0178);

%Reliability Factor Kr
gearbox.pinion1.tooth_bending.Kr = 1; %90% reliability

%corrected fatigue strength
gearbox.pinion1.tooth_bending.corrected_strength = (gearbox.pinion1.tooth_bending.Kl/(gearbox.pinion1.tooth_bending.Kt*gearbox.pinion1.tooth_bending.Kr))*gearbox.pinion1.tooth_bending.uncorrected_strength;

%safety Factor
gearbox.pinion1.tooth_bending.safetyfactor = gearbox.pinion1.tooth_bending.corrected_strength/gearbox.pinion1.tooth_bending.bending_stress;
%% Gear 1

%Dynamic factor Kv
gearbox.gear1.tooth_bending.tang_vel = 0.5*60*gearbox.gear1.geometry.pitchdiameter*gearbox.gear1.geometry.omega/12; %ft/min
gearbox.gear1.tooth_bending.B = ((12-gearbox.gear1.material.quality)^(2/3))/4;
gearbox.gear1.tooth_bending.A = 50+56*(1-gearbox.gear1.tooth_bending.B);
gearbox.gear1.tooth_bending.Kv = (gearbox.gear1.tooth_bending.A/(gearbox.gear1.tooth_bending.A+sqrt(gearbox.gear1.tooth_bending.tang_vel)))^gearbox.gear1.tooth_bending.B;
 
%Load distribution factor Km
if gearbox.gear1.geometry.facewidth<2
    gearbox.gear1.tooth_bending.Km = 1.6;
elseif gearbox.gear1.geometry.facewidth<=6 && gearbox.gear1.geometry.facewidth>=2
    gearbox.gear1.tooth_bending.Km = 1.6 + (1.7-1.6)/(6-2)*(gearbox.gear1.geometry.facewidth-2);
elseif gearbox.gear1.geometry.facewidth>=6 && gearbox.gear1.geometry.facewidth<9
     gearbox.gear1.tooth_bending.Km = 1.7 + (1.8-1.7)/(9-6)*(gearbox.gear1.geometry.facewidth-6);
else
    gearbox.gear1.tooth_bending.Km = 2;
end
 
%Application Factor Ka
gearbox.gear1.tooth_bending.Ka = 1.25; %moderate shock application factor, uniform
 
%Size Factor
gearbox.gear1.tooth_bending.Ks = 1.25; %conservative
 
%Rim Thickness Factor
gearbox.gear1.tooth_bending.Kb = 1; %no rim for now
 
%Idler Factor
gearbox.gear1.tooth_bending.Ki = 1; %no idler
 
%Bending Geometry Factor J
gearbox.gear1.tooth_bending.J = 0.415; %from graph
 
%Bending Stress
gearbox.gear1.tooth_bending.bending_stress = (gearbox.gear1.loads.tang_F*gearbox.gear1.geometry.diametral_pitch*gearbox.gear1.tooth_bending.Ka*gearbox.gear1.tooth_bending.Km*gearbox.gear1.tooth_bending.Ks*gearbox.gear1.tooth_bending.Kb*gearbox.gear1.tooth_bending.Ki)/(gearbox.gear1.geometry.facewidth*gearbox.gear1.tooth_bending.J*gearbox.gear1.tooth_bending.Kv);
 
%uncorrected fatigue strength
gearbox.gear1.tooth_bending.uncorrected_strength = (77.3*gearbox.gear1.material.hardness)+12800;
 
%Temperature Factor Kt
gearbox.gear1.tooth_bending.Kt = 1;
 
%Life Factor Kl
gearbox.gear1.tooth_bending.Kl = 1.3558*((gearbox.pinion2.geometry.N/gearbox.gear2.geometry.N)*gearbox.cycles)^(-0.0178);
 
%Reliability Factor Kr
gearbox.gear1.tooth_bending.Kr = 1; %90% reliability
 
%corrected fatigue strength
gearbox.gear1.tooth_bending.corrected_strength = (gearbox.gear1.tooth_bending.Kl/(gearbox.gear1.tooth_bending.Kt*gearbox.gear1.tooth_bending.Kr))*gearbox.gear1.tooth_bending.uncorrected_strength;
 
%safety Factor
gearbox.gear1.tooth_bending.safetyfactor = gearbox.gear1.tooth_bending.corrected_strength/gearbox.gear1.tooth_bending.bending_stress;

%% Pinion 2

%Dynamic factor Kv
gearbox.pinion2.tooth_bending.tang_vel = 0.5*60*gearbox.pinion2.geometry.pitchdiameter*gearbox.pinion2.geometry.omega/12; %ft/min
gearbox.pinion2.tooth_bending.B = ((12-gearbox.pinion2.material.quality)^(2/3))/4;
gearbox.pinion2.tooth_bending.A = 50+56*(1-gearbox.pinion2.tooth_bending.B);
gearbox.pinion2.tooth_bending.Kv = (gearbox.pinion2.tooth_bending.A/(gearbox.pinion2.tooth_bending.A+sqrt(gearbox.pinion2.tooth_bending.tang_vel)))^gearbox.pinion2.tooth_bending.B;
 
%Load distribution factor Km
if gearbox.pinion2.geometry.facewidth<2
    gearbox.pinion2.tooth_bending.Km = 1.6;
elseif gearbox.pinion2.geometry.facewidth<=6 && gearbox.pinion2.geometry.facewidth>=2
    gearbox.pinion2.tooth_bending.Km = 1.6 + (1.7-1.6)/(6-2)*(gearbox.pinion2.geometry.facewidth-2);
elseif gearbox.pinion2.geometry.facewidth>=6 && gearbox.pinion2.geometry.facewidth<9
     gearbox.pinion2.tooth_bending.Km = 1.7 + (1.8-1.7)/(9-6)*(gearbox.pinion2.geometry.facewidth-6);
else
    gearbox.pinion2.tooth_bending.Km = 2;
end
 
%Application Factor Ka
gearbox.pinion2.tooth_bending.Ka = 1.25; %moderate shock application factor, uniform
 
%Size Factor
gearbox.pinion2.tooth_bending.Ks = 1.25; %conservative
 
%Rim Thickness Factor
gearbox.pinion2.tooth_bending.Kb = 1; %no rim for now
 
%Idler Factor
gearbox.pinion2.tooth_bending.Ki = 1; %no idler
 
%Bending Geometry Factor J
gearbox.pinion2.tooth_bending.J = 0.32; %from graph
 
%Bending Stress
gearbox.pinion2.tooth_bending.bending_stress = (gearbox.pinion2.loads.tang_F*gearbox.pinion2.geometry.diametral_pitch*gearbox.pinion2.tooth_bending.Ka*gearbox.pinion2.tooth_bending.Km*gearbox.pinion2.tooth_bending.Ks*gearbox.pinion2.tooth_bending.Kb*gearbox.pinion2.tooth_bending.Ki)/(gearbox.pinion2.geometry.facewidth*gearbox.pinion2.tooth_bending.J*gearbox.pinion2.tooth_bending.Kv);
 
%uncorrected fatigue strength
gearbox.pinion2.tooth_bending.uncorrected_strength = (77.3*gearbox.pinion2.material.hardness)+12800;
 
%Temperature Factor Kt
gearbox.pinion2.tooth_bending.Kt = 1;
 
%Life Factor Kl
gearbox.pinion2.tooth_bending.Kl = 1.3558*(gearbox.cycles)^(-0.0178);
 
%Reliability Factor Kr
gearbox.pinion2.tooth_bending.Kr = 1; %90% reliability
 
%corrected fatigue strength
gearbox.pinion2.tooth_bending.corrected_strength = (gearbox.pinion2.tooth_bending.Kl/(gearbox.pinion2.tooth_bending.Kt*gearbox.pinion2.tooth_bending.Kr))*gearbox.pinion2.tooth_bending.uncorrected_strength;
 
%safety Factor
gearbox.pinion2.tooth_bending.safetyfactor = gearbox.pinion2.tooth_bending.corrected_strength/gearbox.pinion2.tooth_bending.bending_stress;

%% Gear 2

%Dynamic factor Kv
gearbox.gear2.tooth_bending.tang_vel = 0.5*60*gearbox.gear2.geometry.pitchdiameter*gearbox.gear2.geometry.omega/12; %ft/min
gearbox.gear2.tooth_bending.B = ((12-gearbox.gear2.material.quality)^(2/3))/4;
gearbox.gear2.tooth_bending.A = 50+56*(1-gearbox.gear2.tooth_bending.B);
gearbox.gear2.tooth_bending.Kv = (gearbox.gear2.tooth_bending.A/(gearbox.gear2.tooth_bending.A+sqrt(gearbox.gear2.tooth_bending.tang_vel)))^gearbox.gear2.tooth_bending.B;
 
%Load distribution factor Km
if gearbox.gear2.geometry.facewidth<2
    gearbox.gear2.tooth_bending.Km = 1.6;
elseif gearbox.gear2.geometry.facewidth<=6 && gearbox.gear2.geometry.facewidth>=2
    gearbox.gear2.tooth_bending.Km = 1.6 + (1.7-1.6)/(6-2)*(gearbox.gear2.geometry.facewidth-2);
elseif gearbox.gear2.geometry.facewidth>=6 && gearbox.gear2.geometry.facewidth<9
     gearbox.gear2.tooth_bending.Km = 1.7 + (1.8-1.7)/(9-6)*(gearbox.gear2.geometry.facewidth-6);
else
    gearbox.gear2.tooth_bending.Km = 2;
end
 
%Application Factor Ka
gearbox.gear2.tooth_bending.Ka = 1.25; %moderate shock application factor, uniform
 
%Size Factor
gearbox.gear2.tooth_bending.Ks = 1.25; %conservative
 
%Rim Thickness Factor
gearbox.gear2.tooth_bending.Kb = 1; %no rim for now
 
%Idler Factor
gearbox.gear2.tooth_bending.Ki = 1; %no idler
 
%Bending Geometry Factor J
gearbox.gear2.tooth_bending.J = 0.415; %from graph
 
%Bending Stress
gearbox.gear2.tooth_bending.bending_stress = (gearbox.gear2.loads.tang_F*gearbox.gear2.geometry.diametral_pitch*gearbox.gear2.tooth_bending.Ka*gearbox.gear2.tooth_bending.Km*gearbox.gear2.tooth_bending.Ks*gearbox.gear2.tooth_bending.Kb*gearbox.gear2.tooth_bending.Ki)/(gearbox.gear2.geometry.facewidth*gearbox.gear2.tooth_bending.J*gearbox.gear2.tooth_bending.Kv);
 
%uncorrected fatigue strength
gearbox.gear2.tooth_bending.uncorrected_strength = (77.3*gearbox.gear2.material.hardness)+12800;
 
%Temperature Factor Kt
gearbox.gear2.tooth_bending.Kt = 1;
 
%Life Factor Kl
gearbox.gear2.tooth_bending.Kl = 1.3558*((gearbox.pinion2.geometry.N/gearbox.gear2.geometry.N)*gearbox.cycles)^(-0.0178);
 
%Reliability Factor Kr
gearbox.gear2.tooth_bending.Kr = 1; %90% reliability
 
%corrected fatigue strength
gearbox.gear2.tooth_bending.corrected_strength = (gearbox.gear2.tooth_bending.Kl/(gearbox.gear2.tooth_bending.Kt*gearbox.gear2.tooth_bending.Kr))*gearbox.gear2.tooth_bending.uncorrected_strength;
 
%safety Factor
gearbox.gear2.tooth_bending.safetyfactor = gearbox.gear2.tooth_bending.corrected_strength/gearbox.gear2.tooth_bending.bending_stress;

%% Pinion 3

%Dynamic factor Kv
gearbox.pinion3.tooth_bending.tang_vel = 0.5*60*gearbox.pinion3.geometry.pitchdiameter*gearbox.pinion3.geometry.omega/12; %ft/min
gearbox.pinion3.tooth_bending.B = ((12-gearbox.pinion3.material.quality)^(2/3))/4;
gearbox.pinion3.tooth_bending.A = 50+56*(1-gearbox.pinion3.tooth_bending.B);
gearbox.pinion3.tooth_bending.Kv = (gearbox.pinion3.tooth_bending.A/(gearbox.pinion3.tooth_bending.A+sqrt(gearbox.pinion3.tooth_bending.tang_vel)))^gearbox.pinion3.tooth_bending.B;
 
%Load distribution factor Km
if gearbox.pinion3.geometry.facewidth<2
    gearbox.pinion3.tooth_bending.Km = 1.6;
elseif gearbox.pinion3.geometry.facewidth<=6 && gearbox.pinion3.geometry.facewidth>=2
    gearbox.pinion3.tooth_bending.Km = 1.6 + (1.7-1.6)/(6-2)*(gearbox.pinion3.geometry.facewidth-2);
elseif gearbox.pinion3.geometry.facewidth>=6 && gearbox.pinion3.geometry.facewidth<9
     gearbox.pinion3.tooth_bending.Km = 1.7 + (1.8-1.7)/(9-6)*(gearbox.pinion3.geometry.facewidth-6);
else
    gearbox.pinion3.tooth_bending.Km = 2;
end
 
%Application Factor Ka
gearbox.pinion3.tooth_bending.Ka = 1.25; %moderate shock application factor, uniform
 
%Size Factor
gearbox.pinion3.tooth_bending.Ks = 1.25; %conservative
 
%Rim Thickness Factor
gearbox.pinion3.tooth_bending.Kb = 1; %no rim for now
 
%Idler Factor
gearbox.pinion3.tooth_bending.Ki = 1; %no idler
 
%Bending Geometry Factor J
gearbox.pinion3.tooth_bending.J = 0.32; %from graph
 
%Bending Stress
gearbox.pinion3.tooth_bending.bending_stress = (gearbox.pinion3.loads.tang_F*gearbox.pinion3.geometry.diametral_pitch*gearbox.pinion3.tooth_bending.Ka*gearbox.pinion3.tooth_bending.Km*gearbox.pinion3.tooth_bending.Ks*gearbox.pinion3.tooth_bending.Kb*gearbox.pinion3.tooth_bending.Ki)/(gearbox.pinion3.geometry.facewidth*gearbox.pinion3.tooth_bending.J*gearbox.pinion3.tooth_bending.Kv);
 
%uncorrected fatigue strength
gearbox.pinion3.tooth_bending.uncorrected_strength = (77.3*gearbox.pinion3.material.hardness)+12800;
 
%Temperature Factor Kt
gearbox.pinion3.tooth_bending.Kt = 1;
 
%Life Factor Kl
gearbox.pinion3.tooth_bending.Kl = 1.3558*(gearbox.cycles)^(-0.0178);
 
%Reliability Factor Kr
gearbox.pinion3.tooth_bending.Kr = 1; %90% reliability
 
%corrected fatigue strength
gearbox.pinion3.tooth_bending.corrected_strength = (gearbox.pinion3.tooth_bending.Kl/(gearbox.pinion3.tooth_bending.Kt*gearbox.pinion3.tooth_bending.Kr))*gearbox.pinion3.tooth_bending.uncorrected_strength;
 
%safety Factor
gearbox.pinion3.tooth_bending.safetyfactor = gearbox.pinion3.tooth_bending.corrected_strength/gearbox.pinion3.tooth_bending.bending_stress;

%% Gear 3

%Dynamic factor Kv
gearbox.gear3.tooth_bending.tang_vel = 0.5*60*gearbox.gear3.geometry.pitchdiameter*gearbox.gear3.geometry.omega/12; %ft/min
gearbox.gear3.tooth_bending.B = ((12-gearbox.gear3.material.quality)^(2/3))/4;
gearbox.gear3.tooth_bending.A = 50+56*(1-gearbox.gear3.tooth_bending.B);
gearbox.gear3.tooth_bending.Kv = (gearbox.gear3.tooth_bending.A/(gearbox.gear3.tooth_bending.A+sqrt(gearbox.gear3.tooth_bending.tang_vel)))^gearbox.gear3.tooth_bending.B;
 
%Load distribution factor Km
if gearbox.gear3.geometry.facewidth<2
    gearbox.gear3.tooth_bending.Km = 1.6;
elseif gearbox.gear3.geometry.facewidth<=6 && gearbox.gear3.geometry.facewidth>=2
    gearbox.gear3.tooth_bending.Km = 1.6 + (1.7-1.6)/(6-2)*(gearbox.gear3.geometry.facewidth-2);
elseif gearbox.gear3.geometry.facewidth>=6 && gearbox.gear3.geometry.facewidth<9
     gearbox.gear3.tooth_bending.Km = 1.7 + (1.8-1.7)/(9-6)*(gearbox.gear3.geometry.facewidth-6);
else
    gearbox.gear3.tooth_bending.Km = 2;
end
 
%Application Factor Ka
gearbox.gear3.tooth_bending.Ka = 1.25; %moderate shock application factor, uniform
 
%Size Factor
gearbox.gear3.tooth_bending.Ks = 1.25; %conservative
 
%Rim Thickness Factor
gearbox.gear3.tooth_bending.Kb = 1; %no rim for now
 
%Idler Factor
gearbox.gear3.tooth_bending.Ki = 1; %no idler
 
%Bending Geometry Factor J
gearbox.gear3.tooth_bending.J = 0.415; %from graph
 
%Bending Stress
gearbox.gear3.tooth_bending.bending_stress = (gearbox.gear3.loads.tang_F*gearbox.gear3.geometry.diametral_pitch*gearbox.gear3.tooth_bending.Ka*gearbox.gear3.tooth_bending.Km*gearbox.gear3.tooth_bending.Ks*gearbox.gear3.tooth_bending.Kb*gearbox.gear3.tooth_bending.Ki)/(gearbox.gear3.geometry.facewidth*gearbox.gear3.tooth_bending.J*gearbox.gear3.tooth_bending.Kv);
 
%uncorrected fatigue strength
gearbox.gear3.tooth_bending.uncorrected_strength = (77.3*gearbox.gear3.material.hardness)+12800;
 
%Temperature Factor Kt
gearbox.gear3.tooth_bending.Kt = 1;
 
%Life Factor Kl
gearbox.gear3.tooth_bending.Kl = 1.3558*((gearbox.pinion3.geometry.N/gearbox.gear3.geometry.N)*gearbox.cycles)^(-0.0178);
 
%Reliability Factor Kr
gearbox.gear3.tooth_bending.Kr = 1; %90% reliability
 
%corrected fatigue strength
gearbox.gear3.tooth_bending.corrected_strength = (gearbox.gear3.tooth_bending.Kl/(gearbox.gear3.tooth_bending.Kt*gearbox.gear3.tooth_bending.Kr))*gearbox.gear3.tooth_bending.uncorrected_strength;
 
%safety Factor
gearbox.gear3.tooth_bending.safetyfactor = gearbox.gear3.tooth_bending.corrected_strength/gearbox.gear3.tooth_bending.bending_stress;
