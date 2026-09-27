local board = {}

local RESET = "\27[0m"
local YELLOW = "\27[93m"
local ITALIC = "\27[3m"
local BOLD = "\27[1m"

local function print_little(board, layer, active)
    local START, END = '', ''

    if (active) then 
        START = YELLOW .. BOLD
        END = RESET 
    end

    if (board.winner == 'X') then
        if layer == 1 or layer == 5 then 
            io.write('#       #')
        elseif layer == 2 or layer == 4 then 
            io.write('  #   #  ')
        elseif layer == 3 then
            io.write('    #    ')
        end
    elseif (board.winner == 'O') then 
        if layer == 1 or layer == 5 then 
            io.write('  # # #  ')
        else
            io.write('#       #')
        end
    else 
        if layer == 1 then 
            io.write(START .. board[1] .. ' | ' .. board[2] .. ' | ' .. board[3] .. END) 
        elseif layer == 2 then
            io.write(START .. '--+---+--' .. END) 
        elseif layer == 3 then 
            io.write(START .. board[4] .. ' | ' .. board[5] .. ' | ' .. board[6] .. END)
        elseif layer == 4 then  
            io.write(START .. '--+---+--' .. END)
        elseif layer == 5 then 
            io.write(START .. board[7] .. ' | ' .. board[8] .. ' | ' .. board[9] .. END)
        end
    end

    if active then 
        io.write(RESET)
    end
end

-- SET UP BOARD

board.current = 6

for i = 1, 9 do
    board[i] = {}
    board[i].winner = ' '
    board[i].playable = true
    for j = 1, 9 do
        board[i][j] = ' '
    end
end

function board:print()
    for big_row = 0,2 do
        for layer = 1,5 do 
            print_little(self[3*big_row+1], layer, (3*big_row+1 == self.current))
            io.write(BOLD .. ' | ' .. RESET)
            print_little(self[3*big_row+2], layer, (3*big_row+2 == self.current))
            io.write(BOLD .. ' | ' .. RESET)
            print_little(self[3*big_row+3], layer, (3*big_row+3 == self.current))
            io.write('\n')
        end
        if big_row ~= 2 then 
            io.write(BOLD .. '----------+-----------+----------\n' .. RESET)
        end
    end
end

function board:add(little_board, spot, char)
    board[little_board][spot] = char
    board.current = spot
end

return board 
