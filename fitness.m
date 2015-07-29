function [ val ] = fitness( sol , depot, distance)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    val = 0;
    if ~(sol(1) == -1)
        val = val + depot(sol(1));
    end
    for j = 1:(length(sol)-1)
        if sol(j)== -1 && sol(j+1) == -1
        elseif sol(j) == -1
            val = val + depot(sol(j+1));
        elseif sol(j+1) == -1
            val = val + depot(sol(j));
        else
            val = val + distance(j, j+1);
        end
    end
    if ~(sol(end) == -1)
        val = val + depot(sol(end));
    end
end

