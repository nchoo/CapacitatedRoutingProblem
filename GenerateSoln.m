%Requires varycolor.m
%x, y should be initialized, and are included in the gitrepo
%Takes bestSolution which is a cell array, with each index representing a car
%and containing an array of customers, and plots them

colorMatrix = varycolor(length(bestSolution));
for i = 1:length(bestSolution)
    if ~isempty(bestSolution{i})
        line([0 x(bestSolution{i}(1))],[0 y(bestSolution{i}(1))],'Color', colorMatrix(i,:))
        line([0 x(bestSolution{i}(end))],[0 y(bestSolution{i}(end))],'Color', colorMatrix(i,:))
        for j = 1:length(bestSolution{i})-1
            line([x(bestSolution{i}(j)) x(bestSolution{i}(j+1))],[y(bestSolution{i}(j)) y(bestSolution{i}(j+1))],'Color', colorMatrix(i,:))
        end
    end
end

