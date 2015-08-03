function [ val ] = fitness( sol )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global gdepot
    global gdistance
    val = 0;
    if ~(sol(1) == -1)
        val = val + gdepot(sol(1));
    end
    for j = 1:(length(sol)-1)
        if sol(j)== -1 && sol(j+1) == -1
        elseif sol(j) == -1
            val = val + gdepot(sol(j+1));
        elseif sol(j+1) == -1
            val = val + gdepot(sol(j));
        else
            val = val + gdistance(sol(j), sol(j+1));
        end
    end
    if ~(sol(end) == -1)
        val = val + gdepot(sol(end));
    end
end