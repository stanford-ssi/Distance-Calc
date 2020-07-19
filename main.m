%run this for simulation
clear all;
close all;
clc;

%initialize states
EASVector = [25 30 35 40];
LDVector = [5 4.3 3.6 2.9];
[EASbest, LDbest] = speedOptimize(EASVector,LDVector);
time(1) = 0;
alt(1) = 18000;
wind(1) = windModel(alt(1));
[LDRatio(1), EAS(1)] = aircraftPerformance(alt(1), EASbest, LDbest); %target airspeed and resultant L/D estimated based on altitude
TAS(1) = EAS2TAS(EAS(1), alt(1)); %true air speed
GS(1) = TAS2GS(TAS(1), wind(1)); %ground speed
dist(1) = 0;
glideslope(1) = atan(1/LDRatio(1));
vertSpeed(1) = TAS(1)/LDRatio(1);

i = 1;
dt = 0.05;
while alt(i)>0
    
    %the simulation is ran at a time interval of dt. Time based states that
    %are based on dt should only have (i) on right side of equation, and
    %(i+1) on left side
    time(i+1) = time(i)+dt;
    alt(i+1) = alt(i)-vertSpeed(i)*dt;
    dist(i+1) = dist(i) + GS(i)*dt;
  
    %Non time based states are calculated here. These are not based on
    %previous states, but the current state, which means (i+1) is allowed
    %on the right side of the equatio.
    [LDRatio(i+1), EAS(i+1)] = aircraftPerformance(alt(i+1), EASbest, LDbest);
    glideSlope(i+1) = atan(1/LDRatio(i+1));
    wind(i+1) = windModel(alt(i+1));
    TAS(i+1) = EAS2TAS(EAS(i+1), alt(i+1));
    GS(i+1) = TAS2GS(TAS(i+1), wind(i+1));
    vertSpeed(i+1) = TAS(i+1)/LDRatio(i+1);
    
    dYdX = (alt(i+1)-alt(i))/ (dist(i+1)-dist(i));
    %update sim counter
    i = i+1;
    
   
end

figure
plot(time, dist, time, alt)
title('time vs distances')
xlabel('time (s)')
ylabel('distances')
legend('ground track distance', 'altitude')

figure
plot(dist, alt)
title('2D plot')
xlabel('distance (m)')
ylabel('altitude (m)')

figure
plot(GS, alt, TAS, alt, EAS, alt, wind, alt)
title('altitude vs speeds')
xlabel('speeds (m/s)')
ylabel('altitude (m)')
legend('ground speed', 'True airspeed', 'equivalent airspeed', 'wind speed (true)')

figure
plot(EAS, alt, LDRatio, alt)
title('target parameters')
xlabel('flight parameters assumed')
ylabel('altitude')
legend('Target Equivalent Airspeed', 'Estimated L/D at target EAS');

fprintf("Max distance traveled = %i km\n", dist(end)/1000);