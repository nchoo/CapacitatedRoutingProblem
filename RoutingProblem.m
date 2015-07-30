classdef Particle
    properties
    end
    methods
    end
end

function [ gbest, gbestfit] = RoutingProblem( depot, distance, mass, num, capacity )
%ROUTINGPROBLEM Summary of this function goes here
%   Detailed explanation goes here
%   depot - distance between customer and depot
%   distance - distances between each customer
%   mass - weight of each package for each customer
%   num - number of cars
%   capacity - capacity per car

% set globals
    global gdepot
    global gdistance
    global gmass
    global gnum
    global gcapacity
    global len
    global c
    gdepot = depot;
    gdistance = distance;
    gmass = mass;
    gnum = capacity;
    gcapacity = capacity;
    len = length(depot)+num-1;
    c = 2;

% check conditions
    if (sum(mass) > num * capacity)
        msgID = 'MYFUN:TooMuchMass';
        msg = 'Not enough cars for capacity.';
        baseException = MException(msgID,msg);
        throw(baseException);
    end
    
% Generate initial solutions
    numsol = 10;
    initsol = cell(1,numsol);
    
    for i = 1:numsol
        invalid = 1;
        while invalid == 1
            temp = 1:length(depot);
            temp = cat(2, temp, -1*ones(1,num-1));
            for j = 1:(length(depot)+num-1)
                itemtocar = ceil(length(temp)*rand(1));
                initsol{i}(j) = temp(itemtocar);
                temp(itemtocar) = [];
            end
            invalid = CheckMass(initsol{i});
        end
    end
    
% Calculate fitness

    fitness = zeros(1,numsol);
    for i = 1:numsol
        fitness = Fitness(initsol{i});
    end
    
    pbest = initsol;
    [~, index] = min(fitness);
    gbest = initsol{index};
    velocity = cell(1,numsol);
    %w = 1;
    
    %INSERT CONDITION
    condition = 1;
    maxIters = 100;
    iters = 0;
    while condition
        for i = 1:numsol
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
        iters = iters + 1
        if iters > maxIters;
            condition = 0;
        end
    end
end

function [] = PSO()
    global c

end

function [ invalid ] = CheckMass( sol )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    global gmass
    global gcapacity
    invalid = 0;
    sum = 0;
    for i = 1:length(sol)
        if(sol(i) == -1)
            if(sum > gcapacity)
                invalid = 1;
                return
            end
            sum = 0;
        else
            sum = sum + gmass(sol(i));
        end
    end
    if(sum > gcapacity)
        invalid = 1;
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

function output = Subtract( x, y )
    output = [];
    for i = 1:length(x)
        if(~(x(i)==y(i)))
            temp = find(x == y(i));
            j = 1;
            tempindex = 1;
            while j <= length(temp)
                if ~(x(temp(j)) == y(temp(j)))
                    tempindex = j;
                    j = length(temp);
                end
                j = j+1;
            end
            if ~isempty(temp)
                output = cat(1, output, [i, temp(tempindex)]);
                temp2 = x(temp(tempindex));
                x(temp(tempindex)) = x(i);
                x(i) = temp2;
            end
        end
    end
end

function [ y ] = Addition( swap, x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [j,~] = size(swap);
    for i = 1:j
        temp = x(swap(i,1));
        x(swap(i,1)) = x(swap(i,2));
        x(swap(i,2)) = temp;
    end
    y = x;
end

function [ y ] = Multiply( constant, swap )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    global len
    y = [];
    if ~(isempty(swap))
        if constant <= 0 
        elseif constant < 1
            y = swap(1:ceil((constant/2)*length(swap)),:);
        elseif constant > 1 
            %y = cat(1,swap, swap(ceil((constant/2)*length(swap)),:));
            y = cat(1,swap, ceil(len*rand(ceil((constant/2)*length(swap)),2)));
        elseif constant == 1
            y = swap;
        end
    end
end
