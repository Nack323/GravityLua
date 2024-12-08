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

function Vector_negative(v1)
    --- Adds vectors with each other.
    local v3 = {};
    for i, _ in ipairs(v1) do
        v3[i] = -v1[i]
    end
    return v3
end

function Vector_norm(v)
    --- Adds vectors with each other.
    local normsq = 0;
    for _, vi in ipairs(v) do
        normsq = normsq + vi^2;
    end
    return normsq ^ 0.5;
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



--- Now the simulation

-- the basic algo will be: 
-- velocity
-- position
-- grav field (a function r3 to r3)
-- position = pos + vel * dt
-- vel = vel + grav * dt
--
X = {6.378e6, 0, 0};
V = {6.378e5, 0, 0};
MASS_POINT = {0, 0, 0};
MASS_POINT_MASS = 5.972e24;
GRAV_CONSTANT = 6.67430e-11;
Tprint = Table_printer

function GravityField(v)
    --takes a vector and returns the acceleration field.
    -- for now I will just use a mass point at 0, 0, 0
    local vn = Vector_negative(MASS_POINT);
    local distancev = Vector_addition(v, vn);
    local distancen = Vector_norm(distancev);
    local scalar = - GRAV_CONSTANT * MASS_POINT_MASS
    scalar = scalar / (distancen ^ 3)
    local gf = Vector_scalar_multiplication(scalar, distancev);
    return gf
end

