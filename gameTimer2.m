function timeLeft = gameTimer2(timeLeft,numberIndex,numberStr,gameTimer)
% Function that gets a number, draws the number in terms of minutes:seconds
% the returns the number -1 

% If time left is greater than 0, convert the time in # seconds to
% minute:second form, then convert the minutes and seconds to their index
% in in retro_pack.png.
% else the vector to display 0:00
    if timeLeft > 0
        minutes = floor(timeLeft/60);
        seconds = mod(timeLeft,60) * .01;
        time = minutes + seconds;
        timeStr = num2str(time);
        if length(timeStr) == 1
            timeStr = append(timeStr,'.00');
        elseif length(timeStr) == 3
            timeStr = append(timeStr,'0');
        end
    %     timeVector = []
        for k = 1:length(timeStr)
            for l = 1:11
                if timeStr(k) == numberStr(l) 
                    timeVector(k) = numberIndex(l);
                end
            end
        end
    else
        timeVector = [948 958 948 948];
    end
    
% draw the time
    drawScene(gameTimer,timeVector)
%     movegui(gcf,'northeast')
    timeLeft = timeLeft - 1;
end

 