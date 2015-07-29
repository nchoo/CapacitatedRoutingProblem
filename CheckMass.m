function [ valid ] = CheckMass( sol, mass, capacity )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    valid = 1;
    sum = 0;
    for i = 1:length(sol)
        if(sol(i) == -1)
            if(sum > capacity)
                valid = 0;
                return
            end
            sum = 0;
        else
            sum = sum + mass(i);
        end
    end
end

