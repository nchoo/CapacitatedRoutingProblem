%Requires varycolor.m by Daniel Helmick, RETRIEVED FROM FILE EXCHANGE
%x, y should be initialized, and are included in the gitrepo
%Takes bestSolution which is a cell array, with each index representing a car
%and containing an array of customers, and plots them

function [] = GenerateSolnPSO(x_100, y_100, sol_100_p)
    scatter([0],[0],[],10,'filled');
    hold on
    scatter(x_100,y_100);
    colorMatrix = varycolor(25);
    color = 1;
    if ~(sol_100_p(1) == -1)
        line([0 x_100(sol_100_p(1))],[0 y_100(sol_100_p(1))],'Color', colorMatrix(color,:))
    end

    for i = 1:length(sol_100_p)-1
        if sol_100_p(i) == -1 && sol_100_p(i+1) == -1
        elseif sol_100_p(i) == -1
            line([0 x_100(sol_100_p(i+1))],[0 y_100(sol_100_p(i+1))],'Color', colorMatrix(color,:))
        elseif sol_100_p(i+1) == -1
            line([x_100(sol_100_p(i)) 0],[y_100(sol_100_p(i)) 0],'Color', colorMatrix(color,:))
            color = color + 1;
        else
            line([x_100(sol_100_p(i)) x_100(sol_100_p(i+1))],[y_100(sol_100_p(i)) y_100(sol_100_p(i+1))],'Color', colorMatrix(color,:));
        end
    end
    if ~(sol_100_p(end) == -1)
        line([0 x_100(sol_100_p(end))],[0 y_100(sol_100_p(end))],'Color', colorMatrix(color,:))
    end

