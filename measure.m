function [ rhoSystem ] = measure( systemDM )
%MEASURE Função para medir qbit
%   

[v,d] = eig(systemDM)
for k=1:size(v)
    eigenVector = v(:,k);
    projector = eigenVector * eigenVector';
    probability = systemDM' * projector * systemDM
end

rhoSystem = 1;
end

