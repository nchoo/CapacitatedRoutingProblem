%RUN THIS SCRIPT TO RUN ALGORITHM
    load('input.mat')
%Run 10 customer problem for 10 iterations and plot graph
    %    [sol_10_t,fit_10_t] = RoutingProblem(depot_10, distance_10, mass_10, num_10, capacity_10);
    %    GenerateSolnPSO(x_10, y_10, sol_10_t)
%Run 50 customer problem for 10 iterations and plot graph
    %    [sol_50_t,fit_50_t] = RoutingProblem(depot_50, distance_50, mass_50, num_50, capacity_50);
    %    GenerateSolnPSO(x_50, y_50, sol_50_t)
%Run 100 customer problem for 10 iterations and plot graph
    [sol_100_t,fit_100_t] = RoutingProblem(depot_100, distance_100, mass_100, num_100, capacity_100);
    GenerateSolnPSO(x_100, y_100, sol_100_t)