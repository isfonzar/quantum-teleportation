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
gama = 1;
time = 0;

% Getting the QBit to teleport
qBitToTeleport = getQBitToTeleport()

% Time Operator
timeOperator = exp(-gama*time);

[M1, M2] = getNoiseOperator(timeOperator);

maxEntangledState = (kron(ket0,ket0)+kron(ket1,ket1))/sqrt(2);

system = kron(qBitToTeleport,maxEntangledState);
systemDensityMatrix = system *system'

% Applying noise
K{1} = kron(M1,kron(M1,M1));
K{2} = kron(M1,kron(M1,M2));
K{3} = kron(M1,kron(M2,M1));
K{4} = kron(M1,kron(M2,M2));
K{5} = kron(M2,kron(M1,M1));
K{6} = kron(M2,kron(M1,M2));
K{7} = kron(M2,kron(M2,M1));
K{8} = kron(M2,kron(M2,M2));

rhoAfterNoise = 0;
for (iterator = 1:8)
    rhoAfterNoise = rhoAfterNoise + K{iterator} * systemDensityMatrix * K{iterator}';
end

systemDensityMatrix = rhoAfterNoise

% Applying CNOT Gate
CNOT = kron(CNOT, Id);
systemDensityMatrix = CNOT * systemDensityMatrix * CNOT';

% Applying noise
K{1} = kron(M1,kron(M1,M1));
K{2} = kron(M1,kron(M1,M2));
K{3} = kron(M1,kron(M2,M1));
K{4} = kron(M1,kron(M2,M2));
K{5} = kron(M2,kron(M1,M1));
K{6} = kron(M2,kron(M1,M2));
K{7} = kron(M2,kron(M2,M1));
K{8} = kron(M2,kron(M2,M2));

rhoAfterNoise = 0;
for (iterator = 1:8)
    rhoAfterNoise = rhoAfterNoise + K{iterator} * systemDensityMatrix * K{iterator}';
end

systemDensityMatrix = rhoAfterNoise

H = kron(kron(Hadamard,Id),Id);
systemDensityMatrix = H * systemDensityMatrix * H';

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

finalQBit = operationAfterMeasure(qBitToTeleportAfterMeasurement, channelQBitAfterMeasurement, teleportedQBit)