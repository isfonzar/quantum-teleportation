function [ systemDensityMatrixAfterNoise ] = applyNoise( systemDensityMatrix, M1, M2 )
%APPLYNOISE Applies noise to a density matrix

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

    systemDensityMatrixAfterNoise = rhoAfterNoise;

end

