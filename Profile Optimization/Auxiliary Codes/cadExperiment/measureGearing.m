function [gearing] = measureGearing(centerOfRotation1,centerOfRotation2,initialPositionOfGear1,finalPositionOfGear1,initialPositionOfGear2,finalPositionOfGear2)
%% measureGearing 
% measureGearing is function wich help to measure the gearing of 2 rotating points
% 
% Inputs
%   ro1,ro2                     Initial cycles of gear 1 and gear 2                                                     [double]
%   initialPositionOfGear1 or 2 Initial position of a specific point of gear 1 or gear 2 [x,y] position for each row    [numberOfMeasurements x 2 double]
%   finalPositionOfGear1 or 2   Final position of a specific point of gear 1 or gear 2 [x,y] position for each row      [numberOfMeasurements x 2 double]
%
% Outputs
%   gearing                     Gear ratio of the gear - pinion working pair                                            [numberOfMeasurements x 1 double]
%
numberOfMeasurements = size(initialPositionOfGear1,1);
gearing              = zeros(numberOfMeasurements,1);
for iMeasurement = 1:numberOfMeasurements
dtheta1 = measureVectorRotation(initialPositionOfGear1(iMeasurement,:),finalPositionOfGear1(iMeasurement,:),centerOfRotation1);
dtheta2 = measureVectorRotation(initialPositionOfGear2(iMeasurement,:),finalPositionOfGear2(iMeasurement,:),centerOfRotation2);
gearing(iMeasurement) = dtheta1/dtheta2;
end

end
