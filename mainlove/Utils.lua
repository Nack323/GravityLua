Utils = {}

function Utils.tprint(table)
    for _, el in ipairs(table) do
        io.write(tostring(el) .. ' ')
    end
    io.write('\n')
end

function Utils.tostring(table)
    local rstring = ""
    for _, el in ipairs(table) do
        rstring = rstring .. ' ' .. tostring(el)
    end
    return rstring
end

return Utils
