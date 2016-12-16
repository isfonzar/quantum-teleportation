% Quantum Teleportation Algorhytm
% https://github.com/iiiicaro/quantum-teleportation

clear;
qlib; %@todo Remove qlib dependency

%%% Constants
Id = [1 0; 0 1];
ket0 = [1; 0];
ket1 = [0; 1];
CNOT = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0];
Hadamard = (1/sqrt(2))*[1 1; 1 -1];

r=rand(1,2);
r=r/norm(r);
alfa=r(1,1);
beta=r(1,2);

% QBit on lab A
qBitToTeletransport = alfa * ket0 + beta * ket1

maxEntangledState = (kron(ket0,ket0)+kron(ket1,ket1))/sqrt(2);

system = kron(qBitToTeletransport,maxEntangledState);

CNOT = kron(CNOT, Id);
system = CNOT * system;

H = kron(kron(Hadamard,Id),Id);
system = H * system;

systemDensityMatrix = system * system';

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