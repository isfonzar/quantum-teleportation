function [ time ] = getNoiseDuration()
%GETNOISETIME Inputs the user for the duration of the noise process between
%each step

    disp('Input the desired duration of the noise process between each step');
    disp('Default is 0.00');
    time = input('> ');

end

