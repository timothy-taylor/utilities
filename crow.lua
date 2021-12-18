-- example script
-- a little bit of everything

-- sequin table impl, seq() becomes a callable function
local s = sequins
local seq = s{12,5,5,s{7,5,3}, 3, 7, 5, 12}

-- ASL impl, becomes assigned to an output
local modulation = loop{ to(0.2,1,'rebound')
                     , to(1,dyn{len=1}:wrap(0.5,5),'over')
                     , to(3,2,'sine')
                     }

-- called by the metro in the init function
function sequencer()
    local offset = 1
    output[3].volts = offset + ( seq() / 12 )
    output[4](ar(0.01,0.1,5,'exponential'))
end

-- called at startup
function init()
    -- basic metro impl
    metro[1].event = sequencer
    metro[1].time = 0.2
    metro[1]:start()

    -- basic input setup
    input[1].mode( 'change' )
    input[2].mode( 'stream', 0.2 )

    -- some different output options
    output[1].scale = { 0, 2, 3, 5, 7, 9, 10 }
    for n=1,2 do
        output[n](modulation)
    end
end

-- the input modes callback
input[1].change = function() seq:reset() end
input[2].stream = function(v)
    for n=1,2 do
        output[n].dyn.len = v
    end
end
