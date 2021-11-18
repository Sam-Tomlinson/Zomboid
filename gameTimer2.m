
function timeLeft = gameTimer2(timeLeft,numberIndex,numberStr,gameTimer)
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
    drawScene(gameTimer,timeVector)
%     movegui(gcf,'northeast')
    timeLeft = timeLeft - 1;
end

 