local connection = {}

local function getGameCode()
    return "abc-xyz-my-ultimate-tic-tac-toe-game-code"
end 

function connection.setup()
    io.write("   1) Join Game\n   2) Create Game\n")
    local input = io.read()
    if (input ~= '1' and input ~= '2') then 
        io.write("Please Enter '1' or '2'\n\n")
        return connection.setup()
    elseif (input == '1')
        return connection.join(getGameCode())
    elseif (input == '2')
        return connection.create(getGameCode())
    end
end

function connection.create(gameCode)
    -- TODO:
    -- ask user if they want to be X or O
    -- create message in keyval.org
    -- await a response
    -- exit out of function to begin gameplay
end

function connection.join()
    -- check if message exists in keyval.org 
    -- create a response message in keyval.org
    -- await a response (which will be a first move)
end

return connection
