% Quantum Teleportation Algorhytm
% https://github.com/iiiicaro/quantum-teleportation

clear;

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

systemDensityMatrix = system * system'

% Measuring the first QBit
systemDensityMatrix = measure(systemDensityMatrix, [1 0 0]);

% Measuring the second QBit
systemDensityMatrix = measure(systemDensityMatrix, [0 1 0])

% Se for 01 aplicar bit flip
% Se for 10 aplicar operacao de fase
% Se for 11 aplicar os dois


% Observações:
% Não interfere com o teorema da não-clonagem, pois o estado original é
% destruído (pois há colapso deste estado, devido a medida)