require("util/resources")
require("util/gamestack")
require("util/settings")

require("states/intro")
require("states/game")

-- global subsystems
resources = Resources("data/")
settings = Settings()
settings:load()

-- global variables
SIZE = Vector(love.graphics.getWidth(), love.graphics.getHeight())
HALFSIZE = SIZE / 2
GENERATE_AHEAD = SIZE.x * 2
MIN_HEIGHT = 1000
MAX_HEIGHT = 3000
LIGHT_CANVAS = nil
DEBUG = false
LIGHTRANGE = 300
WINDOWDATA = "a29ujosdkkqjwebanldkjsnldkfmnlasjnd1fkl2qawkcsmnxlkj2ma2"
TRANSLATION = Vector()
DEFAULT_WINDOW_SIZE = Vector(800, 600)
FULLSCREEN = settings:get("fullscreen", false)
MUTE = settings:get("mute", false)
MIN_ZOOM = 0.2
MAX_ZOOM = 1
BACKGROUND_COLORS = {
    {20, 20, 30},
    {40, 40, 60},
    {60, 60, 90}
}
HIGHSCORE = settings:get("hightscore", 0)

function reset()
    -- start game
    states = {}
    states.intro = Intro()
    states.game = Game()
    stack = GameStack()
    stack:push(states.intro)
end

function love.load()
    math.randomseed(os.time())

    setFullscreen(FULLSCREEN)
    setMute(MUTE)

    LIGHT_CANVAS = love.graphics.newCanvas(SIZE:unpack())
    -- load images
    resources:addImage("particle", "particle.png")
    resources:addImage("particle_square", "particle-square.png")
    resources:addImage("particle_thick", "particle-thick.png")
    resources:addImage("spotlight", "spotlight.png")
    resources:addImage("sparkle", "sparkle.png")
    resources:addImage("ring", "ring.png")
    resources:addImage("lantern", "lantern.png")
    resources:addImage("streetlamp1", "streetlamp1.png")
    resources:addImage("airplane", "airplane.png")
    resources:addImage("chainlamp", "chainlamp.png")
    resources:addImage("chain0", "chain0.png")
    resources:addImage("chain1", "chain1.png")
    resources:addImage("key_arrow", "key-arrow.png")
    resources:addImage("key_esc", "key-esc.png")
    resources:addImage("key_space", "key-space.png")
    resources:addImage("key_f", "key-f.png")
    resources:addImage("key_m", "key-m.png")
    resources:addImage("key_q", "key-q.png")

    resources:makeGradientImage("left", {0, 0, 0, 255}, {0, 0, 0, 0}, true)
    resources:makeGradientImage("sky",  {10, 20, 40}, {120, 150, 255})

    -- load fonts
    resources:addFont("normal", "PostazBold-Regular.otf", 20)
    resources:addFont("medium", "PostazBold-Regular.otf", 30)
    resources:addFont("big", "PostazBold-Regular.otf", 60)

    -- load music
    resources:addMusic("background", "Cupids Revenge.ogg")

    -- load sounds
    resources:addSound("bell", "bell.wav")

    resources:load()

    reset()

    resources.music.background:play()
    resources.music.background:setVolume(0.1)
    resources.music.background:setLooping(true)
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
    if k == "f" then
        setFullscreen(not FULLSCREEN)
    elseif k == "m" then
        setMute(not MUTE)
    end
    stack:keypressed(k, u)
end

function love.mousepressed( x, y, button )
    stack:mousepressed(x, y, button)
end

function setFullscreen(fullscreen)
    _, _, fs = love.graphics.getMode()
    if fs == fullscreen then return end

    if fullscreen then
        modes = love.graphics.getModes()
        table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)
        love.graphics.setMode(modes[#modes].width, modes[#modes].height, true)
    else
        love.graphics.setMode(DEFAULT_WINDOW_SIZE.x, DEFAULT_WINDOW_SIZE.y, false)
    end

    local x, y = love.graphics.getMode()
    SIZE = Vector(x, y)
    HALFSIZE = SIZE/2

    LIGHT_CANVAS = love.graphics.newCanvas(SIZE:unpack())

    FULLSCREEN = fullscreen
    settings:set("fullscreen", fullscreen)
    settings:save()
end

function setMute(mute)
    love.audio.setVolume(mute and 0 or 1)
    MUTE = mute
    settings:set("mute", mute)
    settings:save()
end

function love.quit()
end
