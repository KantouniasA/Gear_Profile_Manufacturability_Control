%% cadGearingMeasurements
clear
experimentName      = "First_experiment_0.4Deg.mat";
saveDir             = "C:\Users\Antonis Kantounias\Documents\ergasies\Gear_Profile_Manufacturability\Profile Optimization\Code Validation Eperiments";
fileName            = join([saveDir,experimentName],filesep);

% Calculate the center of gear 1
centerOfRotation1	=       [0, -56.25, 0];

% Calculate the center of gear 2
centerOfRotation2	=       [0, -18.75, 0];

% Calculate the center of gear 2

% Measure initial position of gear1 
initialPositionOfGear1 =    [
                            2.42,-1.35,0.14;
                            2.42,-1.35,0.14;
                            ];

% Measure initial position of gear2  
initialPositionOfGear2 =    [
                            2.49,-1.17,0;
                            2.49,-1.17,0;
                            ];

% Measure final position of gear1 
finalPositionOfGear1 =    [
                            -0.09,-1.50,0.14;
                            -4.48,-1.00,0.14;
                            ];

% Measure final position of gear2  
finalPositionOfGear2 =    [
                            0.21,-1.12,0;
                            -3.8,-1.25,0;
                            ];
                        
 % Calculating the gearing of to gears                       
gearing = measureGearing(centerOfRotation1,centerOfRotation2,initialPositionOfGear1,finalPositionOfGear1,initialPositionOfGear2,finalPositionOfGear2);

% Save the experiment results
save(fileName)