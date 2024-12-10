-- we pretty much only need an addition function and a scalar multiplication
-- function for this to work. 
local love = require("love")
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
    -- print("[")
    -- for _, el in ipairs(table) do
    --     if _ ~= (#table) then
    --         print(" " .. el .. ",")
    --     else
    --         print(" " .. el .. "")
    --     end
    -- end
    -- print("]")
    for _, el in ipairs(table) do
        io.write(tostring(el) .. ' ')
    end
    io.write('\n')
end



--- Now the simulation

-- the basic algo will be: 
-- velocity
-- position
-- grav field (a function r3 to r3)
-- position = pos + vel * dt
-- vel = vel + grav * dt
--
X = {0, 0, 6378e3 + 408e3};
Xdisplay = Vector_scalar_multiplication(1e-11, X)
V = {0, -7660, 0};
-- position and mass of the mass point
MASS_POINT = {0, 0, 0};
MASS_POINT_MASS = 5.97e24;
EARTH_DIAMETER = 6378e3;
-- a constant to keep things accurate
GRAV_CONSTANT = 6.67430e-11;
Tprint = Table_printer
T = 0; --time
Dt = 0.1;

function GravityField(v)
    --takes a vector and returns the acceleration field. for now I will just
    --use a mass point at 0, 0, 0 this will only work with a single point.
    --Later I can do it with multiple ones.
    local vn = Vector_negative(MASS_POINT);
    local distancev = Vector_addition(v,vn);
    local distancen = Vector_norm(distancev);
    local scalar = - GRAV_CONSTANT * MASS_POINT_MASS
    scalar = scalar / (distancen ^ 3)
    local gf = Vector_scalar_multiplication(scalar, distancev);
    return gf
end

--Start the simulation
--
SCALE = 3e-5;
Limit = 3600 * 24 * 28
DEBUG = false;
DISPLAY = 0;
UPDATES_PER_DISPLAY = 100;

-- while T < Limit do
--     T = T + Dt;
--     local gf = GravityField(X);
--     Tprint(X)
--     if DEBUG then
--         Tprint(V)
--         Tprint(gf)
--         print(' ')
--     end
--     X = Vector_addition(X, Vector_scalar_multiplication(Dt, V))--X + V * Dt;
--     V = Vector_addition(V, Vector_scalar_multiplication(Dt, gf))--V + gf * Dt;
-- end

function love.update()
    for _ = 1, UPDATES_PER_DISPLAY do
        T = T + Dt;
        local gf = GravityField(X);
        -- Tprint(X)
        if DEBUG then
            Tprint(V)
            Tprint(gf)
            print(' ')
        end
        X = Vector_addition(X, Vector_scalar_multiplication(Dt, V))--X + V * Dt;
        V = Vector_addition(V, Vector_scalar_multiplication(Dt, gf))--V + gf * Dt;
    end
end
Blinker = 0

Trail_len = 100
Trail = {}
for i = 1, Trail_len do
    Trail[i] = X
end

Counter = 0;
function love.draw()
    Counter = Counter + 1
    love.graphics.ellipse("line", 300, 300, EARTH_DIAMETER * SCALE)
    love.timer.sleep(0.02)
    love.graphics.ellipse("line",  SCALE * X[2] * 0.7 + 300, SCALE * X[3] + 300, 2)
    Trail[math.fmod(Counter, Trail_len) + 1] = X
    for i= 1, Trail_len do
        love.graphics.points(SCALE * Trail[i][2] * 0.7 + 300, SCALE * Trail[i][3] + 300)
    end
    love.graphics.print("T: ".. math.floor(T/3600) .. 'h', 10, 10)
end

