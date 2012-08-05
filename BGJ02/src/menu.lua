require("util/gamestate")
require("util/resources")
require("util/listmenu")

Menu = class("Menu", GameState)

function Menu:__init()
    self.menu = ListMenu({"Start Game", "Credits", "Quit"},
        Vector(100, 340),
        140,
        resources.fonts.huge,
        60)

    self.menu.callback = function(index, text) 
        if index == 1 then
            game:reset()
            self:transitionTo(game)
        elseif index == 2 then
            self:transitionTo(credits)
        elseif index == 3 then
            stopGame()
        end
    end
end

function Menu:start()
    resources.audio.menu_music:play()
    resources.audio.menu_music:setVolume(1)
end

function Menu:stop()
    resources.audio.menu_music:stop()
end

function Menu:update(dt)
    self.menu:update(dt)

    if self.transition then
        resources.audio.menu_music:setVolume(1 - self.transition)
    end
end

function Menu:draw()
    love.graphics.setColor(17, 17, 17)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    self.menu:draw()
end

function Menu:keypressed(k, u)
    self.menu:keypressed(k, u)

    if k == "escape" then
        stopGame()
    end
end

