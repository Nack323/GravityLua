local love = require("love")
M = 100;

X = 0;
Y = 0;
T = 0;
Scalar = 100;

function love.update()
    T = T + 0.1;
    X = math.cos(T);
    Y = math.sin(T);
    print(T)
end

function love.draw()
    love.graphics.print("Hello World", 400, 300)
    love.graphics.ellipse("line", M + X * Scalar, M + Y * Scalar, 4)
end
