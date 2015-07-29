function output = SubtractSol( x, y )
    output = [];
    i = 1;
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