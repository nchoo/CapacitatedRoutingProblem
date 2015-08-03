function [ valid ] = CheckMass( sol, mass, capacity )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    invalid = 0;
    sum = 0;
    for i = 1:length(sol)
        if(sol(i) == -1)
            if(sum > capacity)
                invalid = 1;
                return
            end
            sum = 0;
        else
            sum = sum + mass(sol(i));
        end
    end
    if (sum > capacity)
        invalid = 1;
    end
end

