Gearbox_Parameters
Forces_Torques
Input_Shaft

x = 0:0.01:gearbox.shaft.length;

for i = 1:length(x)
    VB = IN_BM(x(i),gearbox.pinion2.geometry.position(1),gearbox.pinion1.geometry.position(1),gearbox.shaft.length,gearbox.pinion2.loads.F,gearbox.pinion1.loads.F,gearbox.shaft.IN.ROY,gearbox.shaft.IN.ROZ,gearbox.shaft.IN.RLY,gearbox.shaft.IN.RLZ,gearbox.shaft.IN.torsion);
    V(i,1:3) = [x(i);VB(1,1);VB(1,2)];
    B2(i,1:3) = [x(i);VB(2,1);VB(2,2)];
end

figure(1)
plot(V(:,1),V(:,2))

figure(2)
plot(V(:,1),V(:,3))

figure(3)
plot(B2(:,1),((B2(:,2).^2)+(B2(:,3).^2)).^.5)
hold on
plot(B2(:,1),B2(:,2))
hold on
plot(B2(:,1),B2(:,3))

