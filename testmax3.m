for a = 1:3
    for b=1:3
        for c=1:3
            if max3(a,b,c) == max([a,b,c])
                fprintf('yup\n')
            else
                fprintf('nope\n')
            end
        end
    end
end