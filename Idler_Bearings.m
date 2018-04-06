Shafts;

%% Bearing 1 (not finalized yet)
% Try Bearing Number 6313 - Bore Diameter 2.5591 in.

gearbox.bearing1.ID.C = 16000; %lb
gearbox.bearing1.ID.Co = 12500; %lb
gearbox.bearing1.ID.loadFa = abs(gearbox.shaft.ID.bearing1.loads.F(2)); %applied constant thrust
gearbox.bearing1.ID.loadFr = abs(gearbox.shaft.ID.bearing1.loads.F(3)); %radial load
gearbox.bearing1.ID.V = 1; %rotation factor
gearbox.bearing1.ID.X = 0.56; %radial factor (since Fa/VFr > e, where e is 0.303 and Fa/VFr is 3.85)
gearbox.bearing1.ID.Y = 1.41; %thrust factor computed by linear interpolation

gearbox.bearing1.ID.loadP = abs(gearbox.bearing1.ID.X*gearbox.bearing1.ID.V*gearbox.bearing1.ID.loadFr + gearbox.bearing1.ID.Y*gearbox.bearing1.ID.loadFa);

gearbox.bearing1.ID.L10 = (gearbox.bearing1.ID.C/gearbox.bearing1.ID.loadP)^(10/3); %in millions of cycles

%% Bearing 2
% Try Bearing Number 6314 - Bore Diameter 2.7559 in.

gearbox.bearing2.ID.C = 18000; %lb
gearbox.bearing2.ID.Co = 14000; %lb
gearbox.bearing2.ID.loadFa = abs(gearbox.shaft.ID.bearing2.loads.F(2)); %applied constant thrust
gearbox.bearing2.ID.loadFr = abs(gearbox.shaft.ID.bearing2.loads.F(3)); %radial load
gearbox.bearing2.ID.V = 1; %rotation factor
gearbox.bearing2.ID.X = 0.56; %radial factor (since Fa/VFr > e, where e is 0.247 and Fa/VFr is 3.12)
gearbox.bearing2.ID.Y = 1.80; %thrust factor computed by linear interpolation

gearbox.bearing2.ID.loadP = abs(gearbox.bearing2.ID.X*gearbox.bearing2.ID.V*gearbox.bearing2.ID.loadFr + gearbox.bearing2.ID.Y*gearbox.bearing2.ID.loadFa);

gearbox.bearing2.ID.L10 = (gearbox.bearing2.ID.C/gearbox.bearing2.ID.loadP)^(10/3); %in millions of cycles