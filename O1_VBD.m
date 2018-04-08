function [OUT_VY, OUT_VZ, OUT_MY, OUT_MZ] = O1_VBD(gearbox, x)
%This function calculates the bending moment of the output shaft 1.

VY = zeros(1,length(x));
VZ = zeros(1,length(x));
MY = zeros(1,length(x));
MZ = zeros(1,length(x));

for n = 1:length(x)
    
    if x(n)>=0 && x(n) < gearbox.gear1.geometry.position(1)
        
        %X-Y Plane
        VY(n) = gearbox.shaft.O1.bearing1.loads.F(2);
        MY(n) = VY(n) * x(n);
        %X-Z Plane
        VZ(n) = gearbox.shaft.O1.bearing1.loads.F(3);
        MZ(n) = VZ(n) * x(n);
        
    elseif x(n) >= gearbox.gear1.geometry.position(1) && x(n) <= gearbox.shaft.O1.geometry.length

        %X-Y Plane
        VY(n) = gearbox.shaft.O1.bearing1.loads.F(2) + gearbox.gear1.loads.FW(2);
        MY(n) = -(VY(n) * gearbox.gear1.geometry.position(1)) + (VY(n)*(x(n) - gearbox.gear1.geometry.position(1)));
        %X-Z Plane
        VZ(n) = gearbox.shaft.O1.bearing1.loads.F(3) + gearbox.gear1.loads.FW(3);
        MZ(n) = -(VZ(n)*gearbox.gear1.geometry.position(1)) + (VZ(n))*(x(n) - gearbox.gear1.geometry.position(1));
    end
end
OUT_VY = VY;
OUT_VZ = VZ;
OUT_MY = MY;
OUT_MZ = MZ;
end

