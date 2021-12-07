function waitgame(timeWait)
    % The game will pause for timeWait seconds and print: . . . 
    % loops, printing '. ' before pausing for 1/3 of however long the
    % user inputed
    for i = 1:3
        fprintf('. ')
        pause(timeWait/3)
    end 
end
