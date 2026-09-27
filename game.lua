local board = require("board")
local connection = require("connection")

game = {}

function game.await() 
    board:print()
    io.write("Waiting for Oppenent...\n");
    local lboard, spot = connection.receive()
    -- TODO: make sure move is valid
    
    lboard = tonumber(lboard)
    spot = tonumber(spot)

    board:add(lboard, spot, connection.outboundPlayer)
    connection.awaiting = false
   -- TODO: check for a win 
end

local function isdigit(char)
    return char:match("^%d$")
end

function game.play_move()
    board:print()
    io.write("Enter your move [(<board>)<spot>]: ")
    local input = io.read()
    local i1 = string.sub(input,1,1)
    local i2 = string.sub(input,2,2)
    local lboard, spot 
    if #input == 2 
            and isdigit(i1)
            and i1 ~= '0'
            and isdigit(i2)
            and i2 ~= '0' then 
        lboard = i1 
        spot  = i2 
    elseif #input == 1
            and isdigit(i1)
            and i1 ~= '0' then 
        lboard = board.current
        spot   = i1 
    else 
        io.write("Please Enter moves in the correct format!\n")
    end

    -- TODO: make sure move is valid
    --
    lboard = tonumber(lboard)
    spot = tonumber(spot)

    board:add(lboard, spot, connection.localPlayer)
    connection.awaiting = true
    -- TODO: check for a win
    
    connection.send(lboard,spot)
end


function game.init()
    connection.setup() 
    while (true) do
        if connection.awaiting then 
            game.await()
        else
            game.play_move()
        end
    end 
end 

return game
