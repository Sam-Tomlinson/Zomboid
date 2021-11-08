clc; clear; close all;
%Setup simpleGameEngine with retro pack:
pixelBoard = simpleGameEngine('retro_pack.png',16,16,5);
tileSelection = simpleGameEngine('retro_pack.png',16,16,5);
level = simpleGameEngine('retro_pack.png',16,16,5);


%Create Pixel Selector
pixelSelector = ones(32,32);
for i = 1:32
    pixelSelector(i,:) = 32*(i-1)+1:32*(i-1)+32;
end

%Find out what size game level is wanted and create ones vector of that
%size
dim = input('Insert the dimensions your level as a vector:  ');
yourLevel1 = ones(dim(1),dim(2));
yourLevel2 = ones(dim(1),dim(2));

myPixel = 1;
run = true;
state = 1;
moveOn = 0;
while run
switch state
    case 1
        drawScene(pixelBoard,pixelSelector);
        title('Pixel Selector');
        while state == 1
            [rowVal, columnVal, button] = getMouseInput(pixelBoard);
            if isequal(button,1) || isequal(button,2) || isequal(button,3)   
                myPixel = indexer(size(pixelSelector),rowVal,columnVal,1);
            elseif isempty(myPixel)
                myPixel = 1;
            end
            if isempty(button)
                state = 2;
            elseif button == 27
                state = 3;
            end
            drawScene(tileSelection,myPixel);            
            title('Your selection');                        
         end
        
    case 2
        drawScene(level,yourLevel1,yourLevel2);       
        while state == 2            
            [rowVal, columnVal,button] = getMouseInput(level);
            myTile = indexer(size(yourLevel1),rowVal,columnVal);
            if button == 1 
                yourLevel1(myTile) = myPixel;
            elseif isequal(button,2) || isequal(button,8)
                yourLevel1(myTile) = 1;
                yourLevel2(myTile) = 1;
            elseif button == 3 
                yourLevel2(myTile) = myPixel;
            elseif isequal(button,27)
                state = 3;
            else
                state = 1;
            end
            drawScene(level,yourLevel1,yourLevel2);
        end

    case 3
        yesNo = [1023,984,1017;1,1,1;1012,1013,1];
        drawScene(tileSelection,yesNo);
        title('Save and Quit?');
        [rowVal, columnVal] = getMouseInput(tileSelection);
        affirmative = indexer(size(yesNo),rowVal,columnVal,1);
        if affirmative == 1 || affirmative == 2 || affirmative == 3
            run = false;
        else
            state = 1;
        end
     
end      
end
close all;

saveName = input('What do you want to call this level? ','s');
saveName = append(saveName,'.txt');
save(saveName,'yourLevel1','yourLevel2','-ASCII');
fprintf('saved as %s \n',saveName);

