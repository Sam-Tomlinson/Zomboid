function time = gameTimer(startTime,timePassed,gameObject)
    % Calculates and displays the amount of time left.  
    % outputs the time remaining in seconds
    % inputs starting time, time passed, both in seconds.
    % optional: simpleGameEngineObject
    % if the gameObject is inputted, the gameTimer will draw a scene
    % creating a clock that displays the time remaining
    
    %loads variables
    numberStr = load('numberStr.txt');
    numberIndex = load('numberIndex.txt');
    
    % calculates time passed and converts it into a string of
    % minutes.seconds form
    time = startTime - timePassed; % also time remaining in seconds
    if time >= 60
        minutes = floor(time/60);
        seconds = mod(time,60);
    elseif time == 60
        minutes = 1;
        seconds = 0;
    else
        minutes = 0;
        seconds = mod(time,60);
    end
    dispTime = minutes + seconds * 0.01;
    dispTimeStr = num2str(dispTime);
    
    % looping through all of the values in dispTimeStr, checking what value
    % they are.  It will create a new array with the same length as
    % dispTimeStr.  each value of dispTimeIndex corresponds to the index of
    % the number pixel from the retro_pack.jpg.  It is important to note
    % that '.' gets converted to ':' so as to display time properly.  Also
    % this part of the code only runs if the gameObject was inputted.
    if nargin ==3
        for i = 1:length(dispTimeStr)
            for j = 1:length(numberStr)
                if dispTimeStr(i) == numberStr(j)
                    dispTimeIndex(i) = numberIndex(j);
                end
            end
        end
    
    % checks if the time is only three long eg: 1:3 
    % if it is, it adds an extra zero eg: 1:30
    % Also checks if the time is only one long eg: 1
    % if it is, it adds ':00' eg 1:00
        if length(dispTimeIndex) == 3
            dispTimeIndex(end+1) = numberIndex(1);
        elseif length(dispTimeIndex) == 1
            dispTimeIndex(end+1) = numberIndex(11);
            dispTimeIndex(end+1) = numberIndex(1);
            dispTimeIndex(end+1) = numberIndex(1);
        end
        
    % if time is negative just display zero for time    
        if time < 0
            dispTimeIndex = [948 958 948 948];
        end
    
    % draws the scene titled 'Time Remaining'   
        drawScene(gameObject,dispTimeIndex)
        title('Time Remaining')
    end