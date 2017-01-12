function [ M1, M2 ] = getNoiseOperator( timeOperator )
    %GETNOISEOPERATOR Summary of this function goes here
    %   Detailed explanation goes here

    disp('Noise Operator');
    disp('Select an option:');
    disp('[0] - No noise');
    disp('[1] - Bit flip');
    option = input('> ');

    % BitFlip
    if (option == 1)
        M1 = sqrt(timeOperator)*[1 0; 0 1];
        M2 = sqrt(1 - timeOperator)*[0 1; 1 0];
    end

end

