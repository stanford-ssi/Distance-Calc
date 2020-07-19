function [LDRatio, EAS] = aircraftPerformance(altitude, EASVector, LDVector)
    %change your target airspeed based on altitude. At altitudes with lots
    %of head wind, you want to fly faster, at lower altitudes, you'll want
    %to fly slower to reach higher L/D for best glide
    
    %Based on my initial wind model, wind is highest at 9000m, so my EAS
    %table puts the highest target speed at 8000 and 10000m and ramps down
    %on either side of the worst altitude for head wind.
    
    %L/D function will show a similar trend, where worst altitude will
    %experience lower estimated L/D because we are flying faster than
    %optimal. I'm estimaing optimal L/D to be at 15m/s
    altitudeVector = [0 2000 4000 6000 8000 10000 12000 14000 16000];  
    EAS = interp1(altitudeVector,EASVector,altitude,'linear','extrap');
    LDRatio = interp1(altitudeVector,LDVector,altitude,'linear','extrap');
end