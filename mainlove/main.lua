-- we pretty much only need an addition function and a scalar multiplication
-- function for this to work. 
--
love = require("love")
Vecs = require("Vectors")
Utils = require("Utils")


X = {0, 0, 6378e3 + 408e3};
Xdisplay = Vecs.mul(1e-11, X)
V = {0, -8660, 0}; -- 7660 speed looks good
-- position and mass of the mass point
MASS_POINT = {0, 0, 0};
MASS_POINT_MASS = 5.97e24;
EARTH_DIAMETER = 6378e3;
-- a constant to keep things accurate
GRAV_CONSTANT = 6.67430e-11;
Tprint = Utils.tprint
T = 0; --time
Dt = 0.1;

function GravityField(v)
    local vn = Vecs.negative(MASS_POINT);
    local distancev = Vecs.add(v,vn);
    local distancen = Vecs.norm(distancev);
    local scalar = - GRAV_CONSTANT * MASS_POINT_MASS
    scalar = scalar / (distancen ^ 3)
    local gf = Vecs.mul(scalar, distancev);
    return gf
end

--Start the simulation
--
SCALE = 2e-5--3e-5;
Limit = 3600 * 24 * 28
DEBUG = false;
DISPLAY = 0;
UPDATES_PER_DISPLAY = 100;

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
        X = Vecs.add(X, Vecs.mul(Dt, V))--X + V * Dt;
        V = Vecs.add(V, Vecs.mul(Dt, gf))--V + gf * Dt;
    end
end
Blinker = 0

Trail_len = 1000
Trail = {}
for i = 1, Trail_len do
    Trail[i] = X
end

Counter = 0;
function love.draw()
    angle = T/2000
    Xd = Vecs.rotate3d(X, angle)
    Counter = Counter + 1
    love.graphics.ellipse("line", 300, 300, EARTH_DIAMETER * SCALE)
    love.timer.sleep(0.02)
    love.graphics.ellipse("line",  SCALE * Xd[2] + 300, SCALE * Xd[3] + 300, 4)
    Trail[math.fmod(Counter, Trail_len) + 1] = X
    for i= 1, Trail_len do
        Traild = Vecs.rotate3d(Trail[i], angle)
        love.graphics.points(SCALE * Traild[2] + 300, SCALE * Traild[3] + 300)
    end
    love.graphics.print("T: ".. math.floor(T/3600) .. 'h' .. math.floor(math.fmod(T, 3600)/60), 10, 10)
end

