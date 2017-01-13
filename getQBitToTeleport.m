function [ qBitToTeletransport ] = getQBitToTeleport()
    % getQBitToTeleport
    % Prompts the user for an input
    % @returns randomly generated qbit or user input qbit

    %%% Constants
    Id = [1 0; 0 1];
    ket0 = [1; 0];
    ket1 = [0; 1];

    disp('Quantum Teleportation Algorithm');
    disp('Select an option:');
    disp('[1] - Generate a random quantum bit');
    option = input('> ');

    % Generating a random quantum bit
    if (option == 1)
        r=rand(1,2);
        r=r/norm(r);
        alfa=r(1,1);
        beta=r(1,2);

        % QBit on lab A
        qBitToTeletransport = alfa * ket0 + beta * ket1;
        return;
    end
    
    error('Invalid option chosen');
end

