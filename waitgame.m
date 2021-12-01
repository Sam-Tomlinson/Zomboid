function waitgame(timeWait)
    % The game will pause for timeWait seconds and print: . . . 
    for i = 1:3
        fprintf('. ')
        pause(timeWait/3)
    end 
end
