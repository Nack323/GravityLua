Vectors = {}
function Vectors.add(v1, v2)
    --- Adds vectors with each other.
    local v3 = {};
    for i, _ in ipairs(v1) do
        v3[i] = v1[i] + v2[i]
    end
    return v3
end

function Vectors.negative(v1)
    --- Adds vectors with each other.
    local v3 = {};
    for i, _ in ipairs(v1) do
        v3[i] = -v1[i]
    end
    return v3
end

function Vectors.norm(v)
    --- Adds vectors with each other.
    local normsq = 0;
    for _, vi in ipairs(v) do
        normsq = normsq + vi^2;
    end
    return normsq ^ 0.5;
end

function Vectors.mul(scalar, v)
    --- Multiplies a scalar with a vector
    local v3 = {};
    for i, _ in ipairs(v) do
        v3[i] = scalar * v[i];
    end
    return v3
end

return Vectors
