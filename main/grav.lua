-- we pretty much only need an addition function and a scalar multiplication
-- function for this to work. 
--
function Vector_addition(v1, v2)
    --- Adds vectors with each other.
    local v3 = {};
    for i, _ in ipairs(v1) do
        v3[i] = v1[i] + v2[i]
    end
    return v3
end

function Vector_scalar_multiplication(scalar, v)
    --- Multiplies a scalar with a vector
    local v3 = {};
    for i, _ in ipairs(v) do
        v3[i] = scalar * v[i];
    end
    return v3
end

function Table_printer(table)
    --- prints a table in a non offensive manner.
    print("[")
    for _, el in ipairs(table) do
        if _ ~= (#table) then
            print(" " .. el .. ",")
        else
            print(" " .. el .. "")
        end
    end
    print("]")
end

