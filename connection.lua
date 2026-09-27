local keyval = require("keyval")
local socket = require("socket")

local connection = {}

local function getGameCode()
    return "abc-xyz-my-ultimate-tic-tac-toe-game-code"
end 

function connection.setup()
    io.write("   1) Join Game\n   2) Create Game\n")
    local input = io.read()
    connection.code = getGameCode()
    if (input ~= '1' and input ~= '2') then 
        io.write("Please Enter '1' or '2'\n\n")
        return connection.setup()
    elseif (input == '1') then 
        return connection.join()
    elseif (input == '2') then
        return connection.create()
    end
end

function connection.create()
    -- TODO:
    -- ask user if they want to be X or O
    -- create message in keyval.org
    -- await a response
    -- exit out of function to begin gameplay
    io.write("   1) X (1st player)\n   2) O (2nd player)\n")
    local input = io.read()
    if (input ~= '1' and input ~= '2') then 
        io.write("Please Enter '1' or '2'\n\n")
        return connection.create()
    elseif (input == '1') then 
        connection.localPlayer = 'X'
        connection.outboundPlayer = 'O'
    elseif (input == '2') then 
        connection.localPlayer = 'O'
        connection.outboundPlayer = 'X'
    end
    
    keyval.set(connection.code, input)

    while (true) do 
        local response = keyval.get(connection.code)
        if response == 'A' then 
            break
        end
        socket.sleep(5)
    end 

    connection.awaiting = false
    io.write("Connection Succesful!\n")
end

function connection.join()
    -- check if message exists in keyval.org 
    -- create a response message in keyval.org
    -- await a response (which will be a first move)
    local val = keyval.get(connection.code)
    if (val == nil and val ~= '1' and val ~= '2') then 
        io.write("No game exists!\n\n")
        return connection.setup()
    elseif (val == '1') then 
        connection.localPlayer = 'O'
        connection.outboundPlayer = 'X'
    elseif (val == '2') then 
        connection.localPlayer = 'X'
        connection.outboundPlayer = 'O'
    end

    keyval.set(connection.code, 'A')

    connection.awaiting = true 
    io.write("Connection Succesful!\n")
end

function connection.send(board, spot)
    keyval.set(connection.code, connection.localPlayer .. board .. spot)
end

function connection.receive()
    local body = keyval.get(connection.code)
    if (string.sub(body,1,1) ~= connection.outboundPlayer) then 
        socket.sleep(5)
        return connection.receive()
    end

    return tonumber(string.sub(body,2,2)), tonumber(string.sub(body,3,3))
end

return connection
