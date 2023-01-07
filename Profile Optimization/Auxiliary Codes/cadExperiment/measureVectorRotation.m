function [angle] = measureVectorRotation(positionInitial, positionFinal,  positionCenter)

%% Generate vectors
vectorInitial   = positionInitial - positionCenter;
vectorFinal     = positionFinal - positionCenter;

%% Calculate vector angle
angle           = acos( sum(vectorInitial.*vectorFinal)/...
                        (norm(vectorInitial)*norm(vectorFinal)));

end