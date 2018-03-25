gearbox.shaft.IN.RLZ = ((-gearbox.pinion2.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion2.loads.F(3))+((-gearbox.pinion1.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion1.loads.F(3));
gearbox.shaft.IN.RLY = ((-gearbox.pinion2.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion2.loads.F(2))+((-gearbox.pinion1.geometry.position(1)/gearbox.shaft.length)*gearbox.pinion1.loads.F(2));

% gearbox.shaft.IN.ROZ = ((-gearbox.pinion1.loads.F(3)*gearbox.pinion1.geometry.position(1))-(gearbox.pinion2.loads.F(3)*gearbox.pinion2.geometry.position(1)))/gearbox.shaft.length;
% gearbox.shaft.IN.ROY = ((-gearbox.pinion1.loads.F(2)*gearbox.pinion1.geometry.position(1))-(gearbox.pinion2.loads.F(2)*gearbox.pinion2.geometry.position(1)))/gearbox.shaft.length;
% 
% gearbox.shaft.IN.R0Z = -(gearbox.shaft.IN.RLZ+gearbox.pinion1.loads.F(2)+gearbox.pinion2.loads.F(2));
% gearbox.shaft.IN.R0Y = -(gearbox.shaft.IN.RLY+gearbox.pinion1.loads.F(3)+gearbox.pinion2.loads.F(3));

gearbox.shaft.IN.ROZ = -gearbox.shaft.IN.RLZ-gearbox.pinion2.loads.F(3)-gearbox.pinion1.loads.F(3);
gearbox.shaft.IN.ROY = -gearbox.shaft.IN.RLY-gearbox.pinion2.loads.F(2)-gearbox.pinion1.loads.F(2);