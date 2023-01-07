%% cadGearingMeasurements
clear
experimentName      = "First_experiment_0.0Deg_Correct arrangement.mat";
saveDir             = "C:\Users\Antonis Kantounias\Documents\ergasies\Gear_Profile_Manufacturability\Profile Optimization\Code Validation Eperiments";
fileName            = join([saveDir,experimentName],filesep);

% Calculate the center of gear 1
centerOfRotation1	=       [0, -56.25, 0];

% Calculate the center of gear 2
centerOfRotation2	=       [0, -18.75, 0];

% Calculate the center of gear 2

% Measure initial position of gear1 
initialPositionOfGear1 =    [
                            -2.52,-0.06,0;
                            -2.52,-0.06,0;
                            ];

% Measure initial position of gear2  
initialPositionOfGear2 =    [
                            -2.52,0.17,0;
                            -2.52,0.17,0;
                            ];

% Measure final position of gear1 
finalPositionOfGear1 =    [
                            1.54,-0.02,0;
                            3.62,-0.012,0;
                            ];

% Measure final position of gear2  
finalPositionOfGear2 =    [
                            1.54,0.06,0;
                            3.6,0.035,0;
                            ];
                        
 % Calculating the gearing of to gears                       
gearing = measureGearing(centerOfRotation1,centerOfRotation2,initialPositionOfGear1,finalPositionOfGear1,initialPositionOfGear2,finalPositionOfGear2);

% Save the experiment results
save(fileName)