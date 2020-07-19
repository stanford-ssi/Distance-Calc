function density = densityModel(altitude)
%This function calculates density of the air based on altitude using
%standard atmospheric density
%This is only for altitudes between 0 and 25000 meters
    if altitude<11000
        temp = 15.04 - 0.00649 * altitude;
        pres = 101.29 * ((temp + 273.1)/288.08)^5.256;
        density = pres / (0.2869 * (temp + 273.1));
    else
        temp = -56.46;
        pres = 22.65 * exp(1.73 - 0.000157 * altitude);
        density = pres / (0.2869 * (temp + 273.1));
    end
    
end