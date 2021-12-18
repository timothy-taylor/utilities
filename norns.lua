-- script title
-- script attributes

local viewport = { width = 128, height = 64 }
local knobs = { one = 0, two = 0, three = 0 }

-- if using supercollider
engine.name = ""
    
local M = require "musicutil"
local scale = { root = 0, length = 16, notes = {} } 
scale.notes = M.generate_scale_of_length(
                                        scale.root, 
                                        "Minor Pentatonic", 
                                        scale.length
                                        )
    
function init() 
    -- on norns, crow actions are set and then later executed
    crow.output[2].action = "pulse()"
end 

function enc(id,d)
    -- id is encoder number (1..3)
    -- d is delta (-2 .. 2)

    if id == 1 then
        knobs.one = knobs.one + d
    elseif id == 2 then
        knobs.two = knobs.two + d
    elseif id == 3 then
        knobs.three = knobs.three + d
    end
end

function key(n,z)
    -- id is key number (1..3)
    -- z is on(1) or off(0)

    if z == 1 then
        if id == 3 then
            note = scale.notes[math.random(#scale.notes)] / 12
            crow.output[1].volts = note
            crow.output[2]()
        elseif id == 2 then
            -- stuff
        elseif id == 1 then
            -- stuff
        end
    end
end

function redraw()
    local x = 3
    local y = 4

    screen.clear()

    screen.level(10) -- (0..15)
    screen.move(x,y)
    screen.text("example")

    screen.update()
end

function cleanup()
    -- doesn't seem like you have to do this
    -- but just going to put this here just in case
    Metro.free_all()
end

-- good rule of thumb if using an animation
-- is to have dedicated metro running redraw
animate = metro.init()
animate.time = 1.0 / 15
animate.event = function()
   redraw()
end
animate:start()
