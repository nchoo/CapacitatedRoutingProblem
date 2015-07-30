% n = number of cities
n = 100;
%x = 100*(rand(1,n)-0.5);
%y = 100*(rand(1,n)-0.5);
% assume depot is at (0,0)
depot = zeros(1,n);
for i = 1:n
    depot(i) = sqrt(x(i)^2+y(i)^2);
end

distance = zeros(n);
for i = 1:n
    for j = i+1:n
        distance(i,j) = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);
    end
end
scatter([0],[0],[],10,'filled');
hold on
scatter(x,y);
%line([0 x(1)],[0 y(1)]);