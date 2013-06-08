require("util/resources")
require("util/gamestack")

require("states/intro")
require("states/game")

-- global subsystems
resources = Resources("data/")

-- global variables
SIZE = Vector(love.graphics.getWidth(), love.graphics.getHeight())
HALFSIZE = SIZE / 2


function reset()
    -- start game
    states = {}
    states.intro = Intro()
    states.game = Game()
    stack = GameStack()
    stack:push(states.game)
end

function love.load()
    math.randomseed(os.time())

    -- load images
    -- resources:addImage("logo", "logo.png")

    -- load fonts
    resources:addFont("normal", "DejaVuSans.ttf", 20)

    -- load music
    -- resources:addMusic("background", "background.mp3")

    resources:load()

    reset()
end

function love.update(dt)
    stack:update(dt)
end

function love.draw()
    stack:draw()

    -- love.graphics.setFont(resources.fonts.tiny)
    -- love.graphics.print("FPS: " .. love.timer.getFPS(), 5, 5)
end

function love.keypressed(k, u)
    stack:keypressed(k, u)
end

function love.mousepressed( x, y, button )
    stack:mousepressed(x, y, button)
end

function love.quit()
end