local board = {}

local function print_little(board, layer)
    if (board.winner == 'X') then

    elseif (board.winner == 'O') then 

    else 
        if layer == 1 then 
            io.write(board[1] .. ' | ' .. board[2] .. ' | ' .. board[3]) 
        elseif layer == 2 then
            io.write('---------') 
        elseif layer == 3 then 
            io.write(board[4] .. ' | ' .. board[5] .. ' | ' .. board[6])
        elseif layer == 4 then  
            io.write('---------')
        elseif layer == 5 then 
            io.write(board[7] .. ' | ' .. board[8] .. ' | ' .. board[9])
        end
    end
end

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
            print_little(self[3*big_row+1], layer)
            io.write(' || ')
            print_little(self[3*big_row+2], layer)
            io.write(' || ')
            print_little(self[3*big_row+3], layer)
            io.write('\n')
        end
        io.write('-----------------------------------\n')
    end
end


return board 
