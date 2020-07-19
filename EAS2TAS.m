function TAS = EAS2TAS(EAS, altitude)
    %this function transforms equivalent airspeed (speed plane feels) to
    %true airspeed (actual speed relative to air)
    density = densityModel(altitude);
    TAS = EAS * sqrt(1.225/density);
end