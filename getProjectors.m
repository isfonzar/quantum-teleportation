function [ Projector1, Projector2 ] = getProjectors( numOfQBits, qBitToMeasure )
%GETPROJECTORS Returns the projectors
%   Given the amount of qbits in the density matrix, and the qbit to
%   measure, this function returns the projectors to use in the measurement
%   process.

    % Constants
    ket0 = [1; 0];
    ket1 = [0; 1];
    IdentityMatrix = [1 0; 0 1];   
    
    for iterator = 1:1:numOfQBits
        if (iterator == 1)
            if (qBitToMeasure(iterator) == 1)
                Projector1 = ket0 * ket0';
                Projector2 = ket1 * ket1';
            else
                Projector1 = IdentityMatrix;
                Projector2 = IdentityMatrix;
            end
        else
            if (qBitToMeasure(iterator) == 1)
                Projector1 = kron(Projector1, ket0 * ket0');
                Projector2 = kron(Projector2, ket1 * ket1');
            else
                Projector1 = kron(Projector1, IdentityMatrix);
                Projector2 = kron(Projector2, IdentityMatrix);
            end
        end
    end

end

