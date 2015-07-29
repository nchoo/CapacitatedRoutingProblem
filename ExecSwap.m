function [ y ] = ExecSwap( swap, x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:length(swap)
        temp = x(swap(i,1));
        x(swap(i,1)) = x(swap(i,2));
        x(swap(i,2)) = temp;
    end
    y = x;
end

