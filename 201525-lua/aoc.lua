function findCodeAt(targetX, targetY)
    code = 20151125
    index = 2

    while true do
        for x=1,index do
            y = index - x + 1
            code = code * 252533 % 33554393
            if x == targetX and y == targetY then
                return code
            end
        end
        index = index + 1
    end
end

result = findCodeAt(3083, 2978)
print(result)
