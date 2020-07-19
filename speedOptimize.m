function [bestEAS, bestLD] = speedOptimize(EASVector, LDVector)
%inputs below:

altitudeVector = [0 2000 4000 6000 8000 10000 12000 14000 16000]; %analyze at these altitudes
%LD to speed relation, add more breakpoints for better accuracy


%analysis below:

%store results in the following matrix, each row represents results at an
%altitude, each column represents the results at a specific speed
%(i,j) means ith altitude, and jth speed.
EAS = zeros(length(altitudeVector), (max(EASVector)-min(EASVector+1)));
glideRatio = zeros(length(altitudeVector), max(EASVector)-min(EASVector)+1);
LDmatrix = zeros(length(altitudeVector), max(EASVector)-min(EASVector)+1);

for i = 1:1:length(altitudeVector)
    %loop for each altitude in the altitude vector
    wind = windModel(altitudeVector(i)); %wind at this altitude
    for j = 1:1:max(EASVector)-min(EASVector)+1
        %loop for speed varying from min EAS to max EAS, every 1m/s
        EAS(i,j) = EASVector(1)+j-1; %get EAS, store in EAS result matrix
        TAS = EAS2TAS(EAS(i,j), altitudeVector(i)); %get TAS
        LD = interp1(EASVector, LDVector, EAS(i,j)); %get L/D by interpolation
        LDmatrix(i,j) = LD; %store LD in result matrix
        glideslopeair = atan(1/LD); %get glideslope in air frame
        verticalSpeed = TAS/LD; %get vertical speed
        GS = TAS2GS(TAS, wind); %get ground speed
        glideRatio(i,j) = GS/verticalSpeed; %get glideslope in ground frame, store in result matrix
    end
end

for i = 1:1:length(altitudeVector)
    %go through result each row of result matrix matrix, each row is one
    %altitude
    [maxGlide, index] = max(glideRatio(i,:)); %find speed that corresponds to max glideslope in ground frame
    bestEAS(i) = EAS(i,index); %store best EAS at this altitude
    bestLD(i) = LDmatrix(i,index); %store best LD at this altitude
end 

end
