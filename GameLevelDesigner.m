clc; clear; close all;
% Program that lets you design levels, it will save the levels to a text
% file that later can be opened up (in zomboid3).


% Create three different simpleGameEngine objects: pixelBoard,
% tileSelection, and level.  Pixel board will show all of the tiles in
% retro_pack.png.  TileSelection will show what tile is selected.  Level
% will show the level that you are designing.
pixelBoard = simpleGameEngine('retro_pack.png',16,16,5);
tileSelection = simpleGameEngine('retro_pack.png',16,16,5);
level = simpleGameEngine('retro_pack.png',16,16,5);


% Create an array of the size of Retro_pack.png's tile amount, pre
% allocating for speed.
% set pixelSelector an array following style [1,2,3,4,5,6,7,..,32] up to
% 1024.
pixelSelector = ones(32,32);
for i = 1:32
    pixelSelector(i,:) = 32*(i-1)+1:32*(i-1)+32;
end

%Find out what size game level is wanted and create ones vector of that
%size.  Otherwise input a .txt save file to edit.

% Prompt user to make new level or not
% If you press enter, new will be empty and user will be prompted to input
% the dimensions of the level they want to make.
% Otherwise, prompt for the text file of existing level.
% Split the level in to layer 1 and 2.
new = input('Do you want to make a new level? [y]\n','s');
if isempty(new)
    dim = input('Insert the dimensions your level as a vector:  ');
    yourLevel1 = ones(dim(1),dim(2));
    yourLevel2 = ones(dim(1),dim(2));
else
    saveFile = input('Type what saveFile you would like to load: ','s');
    fullLevel = load(saveFile);
    fullDim = size(fullLevel);
    numOfRows = fullDim(1) ./ 2;
    for i = 1:numOfRows
       yourLevel1(i,:) = fullLevel(i,:);
       yourLevel2(i,:) = fullLevel(i+numOfRows,:);
    end
end

% Initializing variables
myPixel = 1;
run = true;
state = 1;
moveOn = 0;
% Loop, a switch statement 
% Case 1: Draw  retro_pack.jpg, find out where user clicks and save the
% tile they clicked on using the getMouseInput and indexer function.  this
% only works if they click on a tile using left, right, or middle click.
% If they press enter move on to Case 2.
% If they press ESC move on to Case 3.

% Case 2: Draw the level that the user is designing.
% Get where the user clicked on the level and replace the blank tile with
% the selected tile.  If the user left clicked, place the tile on layer 1,
% if they right clicked place tile on the second layer.  If they middle
% clicked or pressed backspace, clear all the tiles. 
% If they press ESC move to Case 3
% If they press anything else move back to Case 1

% Case 3: Draw a scene, titled save and exit, that says YES NO
% Get where the user clicks on the scene (either yes or no)
% If they press on No go back to Case 1
% If they press yes end loop and close all figures
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

% Prompt user to title their new level.  Appends .txt to the end of inputed
% string and save the file.
saveName = input('What do you want to call this level? ','s');
saveName = append(saveName,'.txt');
save(saveName,'yourLevel1','yourLevel2','-ASCII');
fprintf('saved as %s \n',saveName);

