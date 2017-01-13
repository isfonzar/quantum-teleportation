% Quantum Teleportation Algorhytm
% https://github.com/iiiicaro/quantum-teleportation

clear;
qlib; %Qlib dependecy

%%% Constants
Id = [1 0; 0 1];
ket0 = [1; 0];
ket1 = [0; 1];
CNOT = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0];
Hadamard = (1/sqrt(2))*[1 1; 1 -1];

% Getting the QBit to teleport
qBitToTeleport = getQBitToTeleport();
qBitToTeleportDensityMatrix = qBitToTeleport * qBitToTeleport';

disp('Quantum bit to teleport');
disp(qBitToTeleportDensityMatrix);

% Time Operator
disp('Apply noise to the teleportation process?');
disp('[1] - No');
disp('[2] - Yes (Teleportation might not fully work. Fidelity to the expected result will be shown');
willApplyNoise = input('> ');

% Throws error if invalid option
if ((willApplyNoise ~= 1) && (willApplyNoise ~= 2))
    error('Invalid option chosen');
end

% Get the noise matrices and time operator
if (willApplyNoise == 2)
    gama = getNoiseIntensity();
    time = getNoiseDuration();
    
    timeOperator = exp(-gama*time);

    [M1, M2] = getNoiseOperator(timeOperator);
end

% The channel and receiver share a maximum entangled state
maxEntangledState = (kron(ket0,ket0)+kron(ket1,ket1))/sqrt(2);

% Density Matrix of the system
system = kron(qBitToTeleport,maxEntangledState);
systemDensityMatrix = system *system';

% Applying noise
if (willApplyNoise == 2)
    systemDensityMatrix = applyNoise(systemDensityMatrix, M1, M2);
end

% Applying CNOT Gate
CNOT = kron(CNOT, Id);
systemDensityMatrix = CNOT * systemDensityMatrix * CNOT';

% Applying noise
if (willApplyNoise == 2)
    systemDensityMatrix = applyNoise(systemDensityMatrix, M1, M2);
end

H = kron(kron(Hadamard,Id),Id);
systemDensityMatrix = H * systemDensityMatrix * H';

% Applying noise
if (willApplyNoise == 2)
    systemDensityMatrix = applyNoise(systemDensityMatrix, M1, M2);
end

% Measuring the first QBit
systemDensityMatrix = measureSingleQBit(systemDensityMatrix, [1 0 0]);

% Measuring the second QBit
systemDensityMatrix = measureSingleQBit(systemDensityMatrix, [0 1 0]);

qBitToTeleportAfterMeasurementDensityMatrix = partial_trace(systemDensityMatrix, [1 0 0]);
qBitToTeleportAfterMeasurement = dm2pure(qBitToTeleportAfterMeasurementDensityMatrix);

channelQBitAfterMeasurementDensityMatrix = partial_trace(systemDensityMatrix, [0 1 0]);
channelQBitAfterMeasurement = dm2pure(channelQBitAfterMeasurementDensityMatrix);

teleportedQBitDensityMatrix = partial_trace(systemDensityMatrix, [0 0 1]);
teleportedQBit = dm2pure(teleportedQBitDensityMatrix);

finalQBitDensityMatrix = operationAfterMeasure(qBitToTeleportAfterMeasurement, channelQBitAfterMeasurement, teleportedQBitDensityMatrix);

disp('Teleported quantum bit:');
disp(finalQBitDensityMatrix);

if (willApplyNoise == 2)
    fidelity = trace(qBitToTeleportDensityMatrix * finalQBitDensityMatrix);
    
    disp('Fidelity of the results over the expected (the closer to 1, the better):');
    disp(fidelity);
end