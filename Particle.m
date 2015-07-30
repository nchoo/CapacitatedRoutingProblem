classdef Particle
    properties
        sol
        fitness
        pbest
        velocity
        progress
    end
    methods
        function obj = Update(solution, velocity)
            obj.sol = solution;
            obj.fitness = Fitness(solution);
        end
    end
end

function [ val ] = Fitness( sol )
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

function [ vel = Velocity()
    
    invalid = 1;
    timesInvalid = 0;
    while invalid == 1
        %inertia = Multiply(w,velocity{i});
        inertia = velocity{i};
        cognitive = Multiply(c*rand(1), Subtract(pbest{i}, initsol{i}));
        social = Multiply(c*rand(1), Subtract(gbest, initsol{i}));
        tempvelo = cat(1, inertia, cognitive, social);
        tempsol = Addition(velocity{i}, initsol{i});
        tempfit = Fitness(tempsol);
        invalid = CheckMass(tempsol);
        timesInvalid = timesInvalid + 1;
        if timesInvalid > 20
            %give up trying to fix
            initsol{i} = pbest{ceil(numsol*rand(1))};
            timesInvalid = 0;
        end
    end
    velocity{i} = tempvelo;
    initsol{i} = tempsol;
    if tempfit < Fitness(pbest{i})
        pbest{i} = initsol{i};
        if tempfit < Fitness(gbest)
            gbest = initsol{i};
            gbestfit = Fitness(gbest);
        end
    end
    fitness(i) = tempfit;
end