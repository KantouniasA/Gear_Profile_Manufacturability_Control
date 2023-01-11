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
                            0,-0.3000343,0.196349;
                            0,-0.3000343,0.196349;
                            ];

% Measure initial position of gear2  
initialPositionOfGear2 =    [
                            0,0,0;
                            0.0002,0,0;
                            ];

% Measure final position of gear1 
finalPositionOfGear1 =    [
                            0.490868,-0.002485,0.196342;
                            0.981698,-0.008910,0.196319;
                            ];

% Measure final position of gear2  
finalPositionOfGear2 =    [
                            0.490809,0.006425,0;
                            0.981286,0.025696,0;
                            ];
                        
 % Calculating the gearing of to gears                       
gearing = measureGearing(centerOfRotation1,centerOfRotation2,initialPositionOfGear1,finalPositionOfGear1,initialPositionOfGear2,finalPositionOfGear2)

% Save the experiment results
save(fileName)