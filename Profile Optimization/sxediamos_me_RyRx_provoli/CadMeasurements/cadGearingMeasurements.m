%% cadGearingMeasurements
clear
experimentName      = "First_experiment_0.4Deg_Correct arrangement.mat";
saveDir             = "C:\Users\Antonis Kantounias\Documents\ergasies\Gear_Profile_Manufacturability\Profile Optimization\Code Validation Eperiments";
fileName            = join([saveDir,experimentName],filesep);

% Calculate the center of gear 1
centerOfRotation1	=       [0, -56.25, 0];

% Calculate the center of gear 2
centerOfRotation2	=       [0, -18.75, 0];

% Calculate the center of gear 2

% Measure initial position of gear1 
initialPositionOfGear1 =    [
                            3.37,1.33,-7.1;
                            3.37,1.33,-7.1;
                            ];

% Measure initial position of gear2  
initialPositionOfGear2 =    [
                            2.83,1.14,-7.1;
                            2.83,1.14,-7.1;
                            ];

% Measure final position of gear1 
finalPositionOfGear1 =    [
                            0.79,1.42,-7.1;
                            -1.6,1.4,-7.1;
                            ];

% Measure final position of gear2  
finalPositionOfGear2 =    [
                            0.44,0.92,-7.1;
                            -1.78,1.01,-7.1;
                            ];
                        
 % Calculating the gearing of to gears                       
gearing = measureGearing(centerOfRotation1,centerOfRotation2,initialPositionOfGear1,finalPositionOfGear1,initialPositionOfGear2,finalPositionOfGear2);

% Save the experiment results
save(fileName)