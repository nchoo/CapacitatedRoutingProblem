function [ initsol ] = RoutingProblem( depot, cost, mass, num, capacity )
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
        initsol{i} = cell(1,num);
    end
    
    for i = 1:numsol
        temp = [1:length(depot)];
        for j = 1:length(depot)
            pickcar = ceil(num*rand(1));
            itemtocar = ceil(length(temp)*rand(1));
            initsol{i}{pickcar} = cat(1, initsol{i}{pickcar}, temp(itemtocar));
            temp(itemtocar) = [];
        end
    end
    
% Calculate fitness

    fitness = zeros(1,numsol);
    for i = 1:numsol
        for j = 1:length(initsol{i})
            if ~isempty(initsol{i}{j})
                fitness(i) = fitness(i) + depot(initsol{i}{j}(1)) + depot(initsol{i}{j}(end));
            end
            for k = 1:length(initsol{i}{j})-1
                fitness(i) = fitness(i) + cost(initsol{i}{j}(k),initsol{i}{j}(k+1));
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

