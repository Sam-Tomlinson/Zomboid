clc, clear, close
%Setup the simpleGameEngine
everything = simpleGameEngine('retro_pack.png',16,16,5);

board = ones(34,32); %Pre Allocating board
for i = 1:32 % looping to make a [32,32] array that counts from 1 - 1024
    board(i,:) = 32*(i-1)+1:32*(i-1)+32;
end
board(33,1:15) = [1023, 1013, 1019, 1016, 1, 1017, 984, 991, 984, 982, 1018, ...
    988, 1013, 1012, 958,]; %Add Text below retro pack images
drawScene(everything,board);
oneNumIndex = 2;
k=1;
while k <= 31
    [row,collumn] = getMouseInput(everything);
    oneNumIndex = (row-1)*32 + collumn 
    board(34,k) = oneNumIndex;
    board(34,k+1) = 724; 
    drawScene(everything,board);
    onward = getKeyboardInput(everything)
    if isequal(onward,'escape')
        break
    elseif isequal(onward,'backspace')
        continue
    else 
        k = k+1;
    end
end
close

    
layer1 = board(34,:)