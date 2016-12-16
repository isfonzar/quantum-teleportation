function [ responseDensityMatrix ] = measureSingleQBit( systemDensityMatrix , qBitToMeasure )
    %MEASURE Functions that measures the system on the first qbit
    % Further description @todo

    % @todo add security verifications (are the parameters correct?)
    
    % Definying the Projectors
    sizeDensityMatrix = length(systemDensityMatrix);
    numOfQBits = log2(sizeDensityMatrix);
    
    [Projector1, Projector2] = getProjectors( numOfQBits, qBitToMeasure);

    if (rand() < 0.5)
        responseDensityMatrix = (Projector1 * systemDensityMatrix * Projector1)/trace(Projector1 * systemDensityMatrix * Projector1);
    else
        responseDensityMatrix = (Projector2 * systemDensityMatrix * Projector2)/trace(Projector2 * systemDensityMatrix * Projector2);
    end
end

