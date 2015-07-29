function [ initsol, fitness ] = RoutingProblem( depot, cost, mass, num, capacity )
%ROUTINGPROBLEM Summary of this function goes here
%   Detailed explanation goes here
%   depot - distance between customer and depot
%   cost - distances between each customer
%   mass - weight of each package for each customer
%   num - number of cars
%   capacity - capacity per car

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
        if ~(initsol{i}(1) == -1)
            fitness(i) = numsol
        end
        for j = 1:length(initsol{i})
            if initsol{i}(j) == -1
                fitness(i) = depot
            end
        end
    end
    
% Insert algorithm here

    

% Check to see if solutions are valid - integrate with main code
% Check if overweight, repeat while valid = 0
valid = 1;
for j = 1:length(initsol{i})
    if isempty(initsol{i}{j})
    elseif sum(mass(initsol{i}{j})) > capacity
        valid = 0;
    end
end

    


end

function [ invalid ] = CheckMass( sol )
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
            sum = sum + mass(i);
        end
    end
end

function [ val ] = fitness( sol )
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





