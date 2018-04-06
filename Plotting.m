clc
close all
clear all

Gearbox_Parameters
Forces_Torques
Idler_Shaft

x = 0:0.01:gearbox.shaft.length;

for i = 1:length(x)
    VB = ID_BM(x(i),gearbox.gear2.geometry.position(1),gearbox.pinion3.geometry.position(1),gearbox.shaft.length,gearbox.gear2.loads.FW,gearbox.pinion3.loads.FW,gearbox.shaft.ID.ROY,gearbox.shaft.ID.ROZ,gearbox.shaft.ID.RLY,gearbox.shaft.ID.RLZ,gearbox.shaft.ID.torsion);
    V(i,1:3) = [x(i);VB(1,1);VB(1,2)];
    B2(i,1:3) = [x(i);VB(2,1);VB(2,2)];
end

figure(1)
plot(V(:,1),V(:,2))

figure(2)
plot(V(:,1),V(:,3))

figure(3)
% plot(B2(:,1),((B2(:,2).^2)+(B2(:,3).^2)).^.5)
% hold on
% plot(B2(:,1),B2(:,2))
% hold on
plot(B2(:,1),B2(:,3))

