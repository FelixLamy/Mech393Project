Gearbox_Parameters;

%% Gear 3
gearbox.gear3.loads.P = 0.675*17000*0.737562*12; %W to (lbf*ft/s)*(in/ft) = lfb*in/s
gearbox.gear3.loads.T = gearbox.gear3.loads.P/gearbox.gear3.geometry.omega; %lbf*in
gearbox.gear3.loads.tang_F = (gearbox.gear3.loads.T*2*gearbox.gear3.geometry.diametral_pitch)/gearbox.gear3.geometry.N;
gearbox.gear3.loads.rad_F = gearbox.gear3.loads.tang_F*tand(gearbox.gear3.geometry.pressure_angle);
gearbox.gear3.loads.F = [0; -(gearbox.gear3.loads.tang_F); - gearbox.gear3.loads.rad_F];   


%% Pinion 3
gearbox.pinion3.loads.tang_F = gearbox.gear3.loads.tang_F;
gearbox.pinion3.loads.rad_F = gearbox.gear3.loads.rad_F;
gearbox.pinion3.loads.T = (gearbox.pinion3.loads.tang_F*gearbox.pinion3.geometry.N)/(2*gearbox.pinion3.geometry.diametral_pitch);
gearbox.pinion3.loads.F = [0; gearbox.pinion3.loads.tang_F; gearbox.pinion3.loads.rad_F];  


%% Gear 2
gearbox.gear2.loads.T = gearbox.pinion3.loads.T;
gearbox.gear2.loads.tang_F = (gearbox.gear2.loads.T*2*gearbox.gear2.geometry.diametral_pitch)/gearbox.gear2.geometry.N;
gearbox.gear2.loads.rad_F = gearbox.gear2.loads.tang_F*tand(gearbox.gear2.geometry.pressure_angle);
gearbox.gear2.loads.F = [0; gearbox.gear2.loads.tang_F; -gearbox.gear2.loads.rad_F];


%% Pinion 2
gearbox.pinion2.loads.tang_F = gearbox.gear2.loads.tang_F;
gearbox.pinion2.loads.rad_F = gearbox.gear2.loads.rad_F;
gearbox.pinion2.loads.T = (gearbox.pinion2.loads.tang_F*gearbox.pinion2.geometry.N)/(2*gearbox.pinion2.geometry.diametral_pitch);
gearbox.pinion2.loads.F = [0; -gearbox.pinion2.loads.tang_F; gearbox.pinion2.loads.rad_F];  


%% Gear 1
gearbox.gear1.loads.P = 0.325*17000*0.737562*12; %W to (lbf*ft/s)*(in/ft) = lfb*in/s
gearbox.gear1.loads.T = gearbox.gear1.loads.P/gearbox.gear1.geometry.omega; %lbf*in
gearbox.gear1.loads.tang_F = (gearbox.gear1.loads.T*2*gearbox.gear1.geometry.diametral_pitch)/gearbox.gear1.geometry.N;
gearbox.gear1.loads.rad_F = gearbox.gear1.loads.tang_F*tand(gearbox.gear1.geometry.pressure_angle);
gearbox.gear1.loads.F = [0; -gearbox.gear1.loads.tang_F; gearbox.gear1.loads.rad_F];


%% Pinion 1

gearbox.pinion1.loads.tang_F = gearbox.gear1.loads.tang_F;
gearbox.pinion1.loads.rad_F = gearbox.gear1.loads.rad_F;
gearbox.pinion1.loads.T = (gearbox.pinion1.loads.tang_F*gearbox.pinion1.geometry.N)/(2*gearbox.pinion1.geometry.diametral_pitch);
gearbox.pinion1.loads.F = [0; gearbox.pinion1.loads.tang_F; -gearbox.pinion1.loads.rad_F];


%% Bearing 1 Input Shaft

gearbox.shaft.IN.bearing1.position = [0;0;0];
%% Bearing 2 Input Shaft

gearbox.shaft.IN.bearing2.position = [0;0;0];
%% Bearing 1 Idler Shaft

gearbox.shaft.ID.bearing1.position = [0;0;0];
%% Bearing 2 Idler Shaft

gearbox.shaft.ID.bearing2.position = [0;0;0];
%% Bearing 1 Output Shaft 1

gearbox.shaft.O1.bearing2.position = [0;0;0];
%% Bearing 2 Output Shaft 1

gearbox.shaft.O1.bearing2.position = [0;0;0];
%% Bearing 1 Output Shaft 2

gearbox.shaft.O2.bearing2.position = [0;0;0];
%% Bearing 2 Output Shaft 2

gearbox.shaft.O2.bearing2.position = [0;0;0];
