Utils = {}

function Utils.tprint(table)
    for _, el in ipairs(table) do
        io.write(tostring(el) .. ' ')
    end
    io.write('\n')
end

return Utils
