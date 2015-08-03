
% returns the total cost of the solution
% solution - first dimension are Cars and 2nd dimension are Customers (2D array)
% depot - distance between customer and depot (1D array)
% cost - distances between each customer (2D array)

function [fitness] = getFitness(solution, depot, cost)
    fitness = 0;
    for i = 1:length(solution)
        if ~isempty(solution{i})
            fitness = fitness + depot(solution{i}(1)) + depot(solution{i}(end));
        end
        for k = 1:length(solution{i})-1
            fitness = fitness + cost(solution{i}(k),solution{i}(k+1));
        end
    end
end
