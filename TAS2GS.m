function GS = TAS2GS(TAS, wind)
% This function transforms True airspeed (speed relative to air) to ground
% speed (speed relative to ground). Positive wind is headwind
    GS = TAS - wind;
end