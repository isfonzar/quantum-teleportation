function [ M1, M2 ] = getNoiseOperator( timeOperator )
    %GETNOISEOPERATOR Summary of this function goes here
    %   Detailed explanation goes here

    disp('Noise Operator');
    disp('Select an option:');
    disp('[1] - Bit flip');
    disp('[2] - Phase flip');
    disp('[3] - Bit-phase flip');
    option = input('> ');

    % Bit flip
    if (option == 1)
        M1 = sqrt(timeOperator)*[1 0; 0 1];
        M2 = sqrt(1 - timeOperator)*[0 1; 1 0];
        return;
    end
    % Phase flip
    if (option == 2)
        M1 = sqrt(timeOperator)*[1 0; 0 1];
        M2 = sqrt(1 - timeOperator)*[1 0; 0 -1];
        return;
    end
    % Bit-phase flip
    if (option == 3)
        M1 = sqrt(timeOperator)*[1 0; 0 1];
        M2 = sqrt(1 - timeOperator)*[0 -1i; 1i 0];
        return;
    end
    
    error('Invalid option. Script aborted');

end

