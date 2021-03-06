classdef Particle
    properties
        sol
        fitness
        pbest
        velocity
        progress
    end
    methods
        function obj = Particle(solution)
            %Generate a new particle and calculate parameters from the
            %solution value
            if nargin > 0
                obj.sol = solution;
                obj.fitness = Fitness(solution);
                obj.pbest = solution;
                obj.velocity = ceil(length(solution)*rand(ceil(length(solution/10)*rand(1)),2));
                obj.progress = 0;
            else
                obj = Particle(NewSoln());
            end
        end
        function [obj]= Next(obj, gbest)
            %iterate to find the next position and velocity
            global c;
            invalid = 1;
            timesInvalid = 0;
            while invalid == 1
            %use PSO formula to calculate the next velocity and position
            %try to find an iteration of the solution that is valid
                %inertia is velocity since w = 1
                inertia = obj.velocity;
                cognitive = Multiply(c*rand(1), Subtract(obj.pbest, obj.sol));
                social = Multiply(c*rand(1), Subtract(gbest.sol, obj.sol));
                tempvelo = cat(1, inertia, cognitive, social);
                tempsol = Addition(tempvelo, obj.sol);
                tempfit = Fitness(tempsol);
                invalid = CheckMass(tempsol);
                timesInvalid = timesInvalid + 1;
                if timesInvalid > 20
                % if invalid 20 times, give up trying to find solution, get random new particle
                    obj = Particle(NewSoln());
                    timesInvalid = 0;
                end
            end
            obj.velocity = tempvelo;
            obj.sol = tempsol;
            obj.fitness = tempfit;
            obj.progress = 0;
            %set pbest if iteration fitness is better than pbest fitness
            if tempfit < Fitness(obj.pbest)
                obj.pbest = obj.sol;
                obj.progress = 1;
            else
                
            end
        end
    end
end

function [ val ] = Fitness( sol )
%Calculate the fitness function
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
%Subtract to positions to get a velocity vector
%velocity vector is the location of swaps requried to change one vector to
%the other
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
% Add a velocity to a vector to a position, apply the swaps in velocity to
% the position vector
    [j,~] = size(swap);
    for i = 1:j
        temp = x(swap(i,1));
        x(swap(i,1)) = x(swap(i,2));
        x(swap(i,2)) = temp;
    end
    y = x;
end

function [ y ] = Multiply( constant, swap )
% Multiply a scalar by a velocity, truncates the velocity vector if less
% than 1, else extends the velocity vector if it is above one.
    y = [];
    swap = swap(randperm(size(swap,1)),:);
    if ~(isempty(swap))
        if constant <= 0 
        elseif constant < 1
            y = swap(1:ceil((constant)*size(swap,1)),:);
        elseif constant > 1 
            y = cat(1,swap, swap(ceil((constant-1)*size(swap,1)),:));
            %y = cat(1,swap, ceil((len/4)*rand(ceil((constant/2)*length(swap)),2)));
        elseif constant == 1
            y = swap;
        end
    end
end

function [ invalid ] = CheckMass( sol )
%Checks the mass of the current solution to ensure that no car is over
%capacity in the solution
%returns 1 if the solution has an overweight car
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


function [ sol ]  = NewSoln()
% Generates a random new solution by randomly assigning each customer to
% random cars
    global gnum
    global gdepot
    global len
    invalid = 1;
    sol = zeros(1,len);
    while invalid == 1
        temp = 1:length(gdepot);
        temp = cat(2, temp, -1*ones(1,gnum-1));
        for j = 1:(length(gdepot)+gnum-1)
            itemtocar = ceil(length(temp)*rand(1));
            sol(j) = temp(itemtocar);
            temp(itemtocar) = [];
        end
        invalid = CheckMass(sol);
    end
   
end