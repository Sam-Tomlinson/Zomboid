% Zomboid escape from the City
% Instructions to play:
% 1.) If you want to play for the first time, clear your workspace.
% 2.) increase size of command window to ~3/4 of the screen
% 3.) When asked for a save file press enter if you do not have one





% Check if player has played before.  It will only clear workspace if you
% haven't played before.  It will also prompt you to input a save file
% which is a 28 long string of 1s and 0s.
if ~exist('playedBefore','var')
    clear;
    dlgtitle = 'Save File';
    prompt = 'Input Your Save File,  otherwise press ENTER';
    numlines = 1;
    dlgTitle = 'Save File';
    definput = {'000000000000000000000000000000'};
    saveFile = inputdlg(prompt,dlgTitle,numlines,definput);
end
    
    
% Loads some variables, closes figures, creates simplegameEngine objects
clc; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5);
secretPanel = simpleGameEngine('retro_pack.png',16,16,5);
numberIndex = load('numberIndex.txt');
numberStr = load('numberStr.txt');
endings = readcell('endings.txt');
timeLeft = 180;
gameClock = timer('ExecutionMode','FixedRate');
set(gameClock,'TimerFcn','timeLeft = gameTimer2(timeLeft,numberIndex,numberStr,clock);');
set(gameClock,'Period',1);

% Initilizing variables
stage = 1;
playedBefore = true;
win = 'You Died';
weapon = 'default';
howLeave = 'default';
attackDoorZombie = 'default';
haveFirstAidKit = false;
transportation = 'default';
howLeaveCar = 'default';
saveCompanion1 = 'default';
companion1 = false;
alleyStreet = 'default';
alleyZombies = 'default';
triedDoor = false;
companion2 = true;
speakToComp = 'default';
companionChoice = 'default';
banditBlockade = 'default';
banditSneak = 'default';
panelDecision = 'default';
dogSave = 'default';
boatBranch = 'default';
roughWater = 'default';
brokenBoat = 'default';
banditZombieFight = 'default';
banditOffer = 'default';
communityChoice = 'default';
communityZombieHoard = 'default';
finalZombies = 'default';


    

    

%Start stuff that is needed for game, but should not be looped
runLevel(zomboid,'startCard.txt')
gameFigure = get(groot,'CurrentFigure');
movegui(gameFigure,'north');

% Main game loop for while stage is not 0 and time left is above 0.  There
% is a switch statement inside the loop that contains all of the plot of
% the game.

% Most of the case statements in the loop follow the following format:
% clear command window
% runLevel 
% print plot and or instructions
% While someVar is default
% set someVar to keyboardInput (from the level)
% depending on what they press, set stage to another value 
% if necessary pring 'press any key to continue' and wait for any input
% (keypress or mouse click).
% If the player found an ending there will also be a line of code that sets the
% savefile for that ending to 1.

% You may notice some of the fprintf statements have some unusual
% characters.  
% fprintf('some text') is normal black text
% fprintf(2,'some text ') is red text
% fprintf('[\bsome text]\b') is orange text
% fprintf('<strong>some text<\strong>') is bold.  The <strong></strong> can
% be combined with normal black text, red text and orange text. 
% Normal black text is for most of the fprintf statements.
% Red text is for when you died, acquired or lost an item, and endings 
%   Where you died.
% Orange text is for the options you have and for endings where you
%   survived.
% Bold normal text is for introducing new characters.

% All of the while loop have a if-elseif-else statement to determine the
% what to do debending on the key pressed.  the else statement will set the
% someVar back to default if any button other than a,b,c, or d was pressed.
% This is to prevent errors if the user mistypes.
while stage ~= 0 && timeLeft > 0
    switch stage
        % break out of loop/end game stage
        case 0
        
        % Intro Text + wait to continue till user presses button
        case 1
            fprintf('A little over a week ago, patient zero escaped a military laboratory unleashing the zombie virus into your city.\n')
            fprintf('Since then, you have been hunkered down in your house waiting for the military to come to your salvation.\n')
            fprintf('Your radio comes to life and a deep voice says,\n')
            pause(.1)
            fprintf(2,'    "This is the United States Military. The city has been deemed a national \n')
            pause(.1)
            fprintf(2, '    threat and will be destroyed by a nuclear blast at nightfall. All survivors must leave the city before then."\n\n')
            waitgame(3)
            fprintf('you must escape\n\npress any key to continue')
            getMouseInput(zomboid);
            stage = 2;

        % Choice of weapon (text + loop)
        case 2
            clc
            runLevel(zomboid,'Bunker.txt')
            start(gameClock)
            clockFigure = get(groot,'CurrentFigure');
            movegui(clockFigure,'northeast');
            fprintf('As you are preparing to leave you have a decision to make: should you take your machete or your handgun?\n')
            fprintf('Both seem essential, but there is only room for one in your pack.\n')
            fprintf(' [\ba.)   Gun\n')
            fprintf(' b.)   Machete]\b\n\n')
            while isequal(weapon,'default')
               weapon = getKeyboardInput(zomboid);
               if isequal(weapon,'a')
                   weapon = 'Gun';
               elseif isequal(weapon,'b')
                   weapon = 'Machete';
               else
                   weapon = 'default';
               end
            end
            stage = 3;
       
        % Choice Which door to leave through (text + loop)
        % Ending #1: Be Sure To Listen
        case 3
            clc
            zombiePresent = randi(2);
            fprintf('You haven???t seen the outside of your house since the outbreak started, and the wood planks you put on the\n')
            fprintf('windows keep you from peaking outside. For all you know there could be a horde of zombies waiting.\n')
            fprintf('Should you leave through the front door or the back door?\n\n')
            fprintf(' [\ba.)   Listen through front door\n')
            fprintf(' b.)   Listen through back door\n')
            fprintf(' c.)   Choose front door\n')
            fprintf(' d.)   Choose back door]\b\n\n')
            while isequal(howLeave,'default')
                howLeave = getKeyboardInput(zomboid);
                if isequal(howLeave,'a')
                    if zombiePresent == 1
                        runLevel(zomboid,'frontDoorCheck.txt')
                        waitgame(randi(5)) % this causes the time it takes to listen be a random integer from 1 to 5
                        fprintf('You hear what sounds like slight shuffling and')
                        waitgame(1)
                        fprintf('grunting\n')
                        runLevel(zomboid,'Bunker.txt')
                    else
                        runLevel(zomboid,'frontDoorCheck.txt')
                        waitgame(randi(5)) % this causes the time it takes to listen be a random integer from 1 to 5
                        fprintf('You hear nothing\n')
                    end
                    howLeave = 'default';
                elseif isequal(howLeave,'b')
                    if zombiePresent == 2
                        runLevel(zomboid,'backDoorCheck.txt')
                        waitgame(randi(5)) % this causes the time it takes to listen be a random integer from 1 to 5
                        fprintf('You hear what sounds like slight shuffling and')
                        waitgame(1)
                        fprintf('grunting\n')
                        runLevel(zomboid,'Bunker.txt')
                    else
                        runLevel(zomboid,'backDoorCheck.txt')
                        waitgame(randi(5)) % this causes the time it takes to listen be a random integer from 1 to 5
                        fprintf('You hear nothing\n')
                    end
                    howLeave = 'default';
                elseif isequal(howLeave,'c')
                    if zombiePresent == 1
                        runLevel(zomboid,'frontDoorZombie.txt')
                        fprintf('You open the door to walk straight into a zombie. It bites your neck and your scream echoes for miles.\n')
                        fprintf('Your journey ends as soon as it starts.\n')
                        pause(.5)
                        fprintf(2,'\n\nYou Died ')
                        fprintf('\n\npress any key to continue')
                        runLevel(zomboid,'frontDoorZombieDead.txt')
                        getMouseInput(zomboid);
                        stage = 0;
                        %win = false;
                        saveFile{1}(1) = 1;
                    else
                        runLevel(zomboid,'frontDoorSafe.txt')
                        pause(.5)
                        runLevel(zomboid,'outsideFront.txt')
                        stage = 4;
                    end
                elseif isequal(howLeave,'d')
                    if zombiePresent == 2
                        runLevel(zomboid,'backDoorZombie.txt')
                        fprintf('You open the door to walk straight into a zombie. It bites your neck and your scream echoes for miles.\n')
                        fprintf('Your journey ends as soon as it starts.\n')
                        pause(.5)
                        fprintf(2,'\n\nYou Died ')
                        fprintf('\n\npress any key to continue')
                        runLevel(zomboid,'backDoorZombieDead.txt')
                        getMouseInput(zomboid);
                        stage = 0;
                        %win = false;
                        saveFile{1}(1) = 1;
                    else
                        runLevel(zomboid,'backDoorSafe.txt')
                        pause(.5)
                        runLevel(zomboid,'outsideBack.txt')
                        stage = 4;
                    end
                else
                    howLeave = 'default';
                end
            end
        
        % Choice Kill Zombie? (text + loop)
        % Ending #2: Shhhhhh!!!
        case 4 
        clc;
        fprintf('You carefully open the door. It is all clear. You walk outside to notice there is a zombie at the other\n')
        fprintf('entrance. You were that close to walking into your death. You need to be careful. What should you do\n')
        fprintf('about the zombie?\n\n')
        fprintf(' [\ba.)   Attack it\n')
        fprintf(' b.)   Sneak past it]\b\n\n')
        while isequal(attackDoorZombie,'default')
            attackDoorZombie = getKeyboardInput(zomboid);
            if isequal(attackDoorZombie,'a')
                if isequal(weapon,'Gun')
                    runLevel(zomboid,'outsideGunPre.txt')
                    fprintf('You carefully aim your handgun and shoot. You nail the zombie in the head. Easy kill. Then you hear \n')
                    fprintf('noises from all around you. You look to see that you are surrounded by a horde. The gunshot drew at\n')
                    fprintf('least 20 other zombies over to you. You are torn limb from limb.\n\n')
                    pause(.5)
                    runLevel(zomboid,'outsideGunPost.txt')
                    pause(1)
                    runLevel(zomboid,'outsideGunPostZom.txt')
                    pause(.5)
                    fprintf(2,'You Died ')
                    fprintf('\n\npress any key to continue')
                    runLevel(zomboid,'outsideGunPostZomDead.txt')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(2) = 1;
                else
                    runLevel(zomboid,'outsideGunPre.txt')
                    pause(.5)
                    runLevel(zomboid,'outsideMachetePre.txt')
                    pause(.5)
                    fprintf('You sneak close to the zombie until you are an arm''s length away and swiftly cut through its head with\n')
                    fprintf('your machete. You look down at the body to see that it was carrying something.\n\n')
                    fprintf(2,'First Aid Kit Acquired ')
                    fprintf('\n\npress any key to continue')
                    runLevel(zomboid,'outsideMachetePost.txt')
                    getMouseInput(zomboid);
                    haveFirstAidKit = true;
                    runLevel(zomboid,'outsideMachetePostWalk.txt')
                    pause(.5)
                    stage = 5;
                end                
            elseif isequal(attackDoorZombie,'b')
                if isequal(howLeave,'c')
                    runLevel(zomboid,'outsideFrontWalk.txt')
                    pause(.5)
                else
                    runLevel(zomboid,'outsideBackWalk.txt')
                    pause(.5)
                end
                stage = 5;
            else 
                attackDoorZombie = 'default';
            end
        end
        
        
        % How to escape (text + loop)
        % Ending #3: Hiker
        case 5
        clc;
        runLevel(zomboid,'crossroads.txt')
        fprintf('As you walk away from your house you must quickly decide how you will escape. You could attempt to\n')
        fprintf('run on foot, take your car, or steal a boat docked in the nearby river.\n\n')
        fprintf(' [\ba.)   Walk\n')
        fprintf(' b.)   Take a car\n')
        fprintf(' c.)   Take a boat]\b\n\n')
        while isequal(transportation,'default')
           transportation = getKeyboardInput(zomboid);
           if isequal(transportation,'a')
               fprintf('You walk down the street at a swift pace, but the sun begins to set faster than you expected. You move\n')
               fprintf('faster but you quickly realize that you won???t make it out of the city before nightfall. As the sun sets you\n')
               fprintf('see the bomb fall, and the bright light that follows its descent.\n\n')
               stop(gameClock);
               set(gameClock,'Period',0.01);
               start(gameClock);
               while timeLeft >= 1
                    runLevel(zomboid,'crossroadsWalking1.txt')
                    pause(.2)
                    runLevel(zomboid,'crossroadsWalking2.txt')
                    pause(.2)
                    runLevel(zomboid,'crossroadsWalking3.txt')
                    pause(.2)
                    runLevel(zomboid,'crossroadsWalking4.txt')
                    pause(.2)
                    runLevel(zomboid,'crossroadsWalking5.txt')
                    pause(.2)
                    runLevel(zomboid,'crossroadsWalking6.txt')
                    pause(.2)
               end
               fprintf(2,'You Died ')
               fprintf('\n\npress any key to continue')
               getMouseInput(zomboid);
               stage = 0;
               saveFile{1}(3) = 1;
           elseif isequal(transportation,'b')
               stage = 6;
           elseif isequal(transportation,'c')
               stage = 18;
           else
               transportation = 'default';
           end
        end
        
        % What to do when surrounded in car (text + loop)
        % Ending #4: Patience Isn't Key
        case 6
            clc;
            runLevel(zomboid,'crossroadsCar1.txt')
            pause(.5)
            runLevel(zomboid,'crossroadsCar2.txt')
            pause(.5)
            runLevel(zomboid,'crossroadsCar2Zombies.txt')
            fprintf('You get behind the wheel of your car and drive down the street. You feel you are making great progress.\n')
            fprintf('You turn a corner and run into a horde of over 30 zombies. They surround your car, and you are unable\n')
            fprintf('to move forward. What do you do?\n\n')
            fprintf(' [\ba.)   Wait it out\n')
            fprintf(' b.)   Honk Horn and hope someone hears\n')
            fprintf(' c.)   Attack the zombies and make a break for it]\b\n\n')
            while isequal(howLeaveCar,'default')
                howLeaveCar = getKeyboardInput(zomboid);
                if isequal(howLeaveCar,'a')
                    fprintf('You decide to wait and lay low hoping they will ignore you and leave. The next few hours go by and you\n')
                    fprintf('begin to realize that they will not leave in time.')
%                     timeLeft2 = timeLeft
                    stop(gameClock);
%                     timeLeft = timeLeft2;
                    set(gameClock,'Period',0.05);
                    start(gameClock);
                    while timeLeft >= 0
                        
                        pause(1)
                    end
                    fprintf('\nThe bomb hits you and you perish.\n\n')
                    fprintf(2,'You Died ')
                    fprintf('\n\npress any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(4) = 1;
                elseif isequal(howLeaveCar,'b')
                    stage = 7;
                elseif isequal(howLeaveCar,'c')
                    if isequal(weapon,'Gun')
                        fprintf('You ready yourself with your pistol in hand. You move to the back seat where less zombies are gathered\n')
                        fprintf('around the car. You take a deep breath and slam the door open. You fire two shots at the closest\n')
                        fprintf('zombies and push forward. As you book it between the two dead zombies, a third grabs your leg and\n')
                        fprintf('you fall. You are able to kick it away and escape at the last second, but you dropped your handgun in the\n')
                        fprintf('process\n\n')
                    else
                        fprintf('You ready yourself with your machete in hand. You move to the back seat where less zombies are\n')
                        fprintf('gathered around the car. You take a deep breath and slam the door open. You kick the first zombie back\n')
                        fprintf('and cut through the one next to it. You keep slicing through as you go and you break you threw the\n')
                        fprintf('horde. However, as you slice through the last zombie the blade of your machete separates from the\n')
                        fprintf('handle making it useless\n\n')
                    end
                    runLevel(zomboid,'crossroadsCar2ZombiesEscape1.txt')
                    pause(.5)
                    runLevel(zomboid,'crossroadsCar2ZombiesEscape2.txt')
                    pause(.5)
                    runLevel(zomboid,'crossroadsCar2ZombiesEscape3.txt')
                    pause(.5)
                    fprintf(2,'%s lost \n\n',weapon)
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    weapon = 'none';
                    stage = 8;
                else
                    howLeaveCar = 'default';
                end
            end
            
        % Help your rescuer? (text + loop)
        % Ending #5: Zombies aren't Bears
        %   Because you don't have to run faster then the bear, just your
        %   friend.  But this is evidently not the case for zombies.
        case 7
            clc;
            runLevel(zomboid,'crossroadsCar2ZombiesHonk1.txt')
            pause(.5)
            runLevel(zomboid,'crossroadsCar2ZombiesHonk2.txt')
            pause(.5)
            runLevel(zomboid,'crossroadsCar2ZombiesHonk3.txt')
            fprintf('You honk the car horn hoping that someone will help. You sit there waiting. All of a sudden you here\n')
            fprintf('rifle shots, and the zombies outside your car window begin dropping one by one until they are all dead.\n')
            fprintf('Once the last one is dead you go outside to see a man who is in horrible shape. He has a deep cut in his\n')
            fprintf('leg that appears to be infected. When you exit the car, he looks at you sternly and asks for first aid. He\n')
            fprintf('says it''s only fair since he saved you. What do you do?\n')
            if haveFirstAidKit == true
                fprintf('You have a first aid kit, do you use it to save the stranger?\n\n')
                fprintf(' [\ba.)   Yes\n')
                fprintf(' b.)   No]\b\n\n')
                while isequal(saveCompanion1,'default')
                   saveCompanion1 = getKeyboardInput(zomboid);
                   if isequal(saveCompanion1,'a')
                       fprintf('Considering he just saved your life; you are happy to give the first aid kit to the man. As he bandages\n')
                       fprintf('himself up, he introduces himself as <strong>Tyler</strong>, and tells you he got cut bad from falling on broken glass. He\n')
                       fprintf('offers to join you on your escape from the city, and you accept.\n\n')
                       fprintf(2,'Companion Acquired ')
                       fprintf('\n\npress any key to continue')
                       getMouseInput(zomboid);
                       companion1 = true;
                       haveFirstAidKit = 'false';
                       stage = 8;
                   elseif isequal(saveCompanion1,'b')
                       fprintf('You decide that you should save the first aid kit for yourself. You never know when you might need it.\n')
                       fprintf('You tell the man that you can???t help him. ???that???s too bad??? he says. He pulls his rifle up and shoots you.\n\n')
                       fprintf(2,'You Died ')
                       fprintf('\n\npress any key to continue')
                       runLevel(zomboid,'crossroadsCar2ZombiesHonk3Dead.txt')
                       getMouseInput(zomboid);
                       stage = 0;
                       saveFile{1}(5) = 1;
                   else
                       saveCompanion1 = 'default';
                   end
                end
            else
                fprintf('\nThe man mutters something about a waste of time and bullets. He pulls his rifle up and shoots you.\n\n')
                fprintf(2,'You Died ')
                getMouseInput(zomboid);
                stage = 0;
                saveFile{1}(5) = 1;
            end
        
        % Which direction to escape in (text + loop)
        case 8
            clc;
            if companion1 == true
                runLevel(zomboid,'roadCompChoice.txt')
                fprintf('You and Tyler pull yourselves together and must quickly decide which way to take. You could go down\n')
                fprintf('the street, but there may be more hordes of zombies. Or you could go through the alleys, but if you get\n')
                fprintf('cornered there is no escape.\n\n')
            else
                runLevel(zomboid,'roadChoice.txt')
                fprintf('You pull yourself together and must quickly decide which way to take. You could go down the street, but\n')
                fprintf('there may be more hordes of zombies. Or you could go through the alleys, but if you get cornered there\n')
                fprintf('is no escape.\n\n')
            end
            fprintf(' [\ba.)   enter the alley\n')
            fprintf(' b.)   continue along the street]\b\n\n')
            while isequal(alleyStreet,'default')
                alleyStreet = getKeyboardInput(zomboid);
                if isequal(alleyStreet,'a')
                    stage = 9;
                elseif isequal(alleyStreet,'b')
                    stage = 15;
                else
                    alleyStreet = 'default';
                end
            end
                
                    
        % What to do about the zombies in the alley (text + loop)
        % Ending #6: Knock Knock
        case 9
            clc;
            if companion1 == true
                runLevel(zomboid,'alleyComp.txt')
                pause(.5)
                runLevel(zomboid,'alleyCompZombies.txt')
                fprintf('You decide it is best to take the alley, believing the street will only be more dangerous. You and Tyler\n')
                fprintf('move quickly but carefully. You pass by a dumpster and an arm grabs your leg. You scream and pull free.\n')
                fprintf('A zombie crawls out from under the dumpster which Tyler quickly kills, but the noise attracts more\n')
                fprintf('zombies. You both run to the end of the alley, but it leads to a dead end besides a door that leads to the\n')
                fprintf('nearby shop. Zombies are fast approaching.\n\n')
            else
                runLevel(zomboid,'alley.txt')
                pause(.5)
                runLevel(zomboid,'alleyZombies.txt')
                fprintf('You decide it is best to take the alley, believing the street will only be more dangerous. You move quickly\n')
                fprintf('but carefully. You pass by a dumpster and an arm grabs your leg. You scream and pull free. A zombie\n')
                fprintf('crawls out from under the dumpster and the noise attracts even more. You??run to the end of the alley,\n')
                fprintf('but it leads to a dead end besides a door that leads to the nearby shop. Zombies are fast approaching.\n\n')
            end
            fprintf('The alley dead ends at a door, you turn around and see zombies approaching\n')
            fprintf(' [\ba.)   Try the door\n')
            fprintf(' b.)   Fight the zombies]\b\n\n')
            while isequal(alleyZombies,'default')
                alleyZombies = getKeyboardInput(zomboid);
                if isequal(alleyZombies,'a') && triedDoor == true
                    if companion1 == true
                        runLevel(zomboid,'alleyCompZombiesOpen.txt')
                    else
                        runLevel(zomboid,'alleyZombiesOpen.txt')
                    end
                    fprintf('You keep pulling on the door while banging over and over again. Last second the door swings open and\n')
                    fprintf('you leap inside.  You look up to see that a woman is your savior. She has a gun pointed in your direction\n')
                    fprintf('in case you try anything, but you quickly reassure her that you mean no harm. She introduces herself as\n')
                    fprintf('<strong>Alex</strong> and tells you that zombies are blocking all entrances and she has been stuck here for days.\n')
                    fprintf('There is nothing to do besides wait.\n\n')
                    fprintf(2,'Companion two Acquired ')
                    fprintf('\n\npress any key to continue')
                    getMouseInput(zomboid);
                    companion2 = true;
                    stage = 10;
                elseif isequal(alleyZombies,'b')
                    fprintf('You begin to fight the zombies, but they just keep coming. Your backs are pushed to the wall, and you\n')
                    fprintf('cannot keep up with the horde of zombies.\n\n')
                    fprintf(2,'You Died ')
                    fprintf('\n\npress any key to continue')
                    if companion1 == true
                        runLevel(zomboid,'alleyCompZombiesDead.txt')
                    else
                        runLevel(zomboid,'alleyZombiesDead.txt')
                    end
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(6) = 1;
                elseif isequal(alleyZombies,'a') 
                    fprintf('You quickly go for the door and try to open it. It is locked. The zombies are only a few feet away.\n')
                    triedDoor = true;
                    alleyZombies = 'default';
                else
                    alleyZombies = 'default';
                end
            end
        
        % Speak with the person (text + loop), this originally may have
        % been a point to add a secret another branch, however now just
        % serves to take time possibly causing someone to get the
        % 'slowpoke' ending.
        case 10
            clc;
            if companion1 == true
                runLevel(zomboid,'AlleyCompInside.txt')
            else
                runLevel(zomboid,'AlleyInside.txt')
            end
            fprintf('Do you talk to Alex or remain silent?\n')
            fprintf(' [\ba.)   Speak\n')
            fprintf(' b.)   Remain Silent]\b\n\n')
            while isequal(speakToComp,'default')
                speakToComp = getKeyboardInput(zomboid);
                if isequal(speakToComp,'a')
                    fprintf('Alex tells you that soon after the outbreak her and her friend took shelter in the store hoping for\n')
                    fprintf('rescue. A few days later her close friend left to get supplies and never returned. Not long after that zombies\n')
                    fprintf('crowded the street by the front door leaving her trapped. She says she must leave the city and return to\n')
                    fprintf('her family outside of town.\n\n')
                    fprintf('press any key to continue')
                    getMouseInput(zomboid);
                elseif isequal(speakToComp,'b')
                else
                    speakToComp = 'default';
                end
            end
            stage = 11;
        
        % Check if you survive based on your weapon (text + loop)
        % Ending #7: At least bring a knife
        %   Because 'Don't bring a knife to a gun fight', but you don't
        %   have any weapon in this senario
        case 11
            clc;
            if isequal(weapon,'none')
                runLevel(zomboid,'alleyInsideZombies.txt')
                pause(.5)
                runLevel(zomboid,'alleyInsideZombiesDead.txt')
                fprintf('The zombies out front heard the commotion and have been banging on the front door and\n')
                fprintf('the windows ever since. The window is beginning to steadily crack. You begin looking for a way out and\n')
                fprintf('notice a locked third entrance behind the counter that leads to the other side of the store, but the key\n')
                fprintf('is nowhere to be found. As you look around, suddenly you hear the window shatter, and the zombies\n')
                fprintf('begin flooding in. They attack Alex and tear her apart. You scramble around looking for a way out but\n')
                fprintf('it is too late. The zombies tear into you.\n\n')
                fprintf(2,'You Died ')
                fprintf('\n\npress any key to continue')
                getMouseInput(zomboid);
                stage = 0;
                saveFile{1}(7) = 1;
            else
                stage = 12;
            end
        
        % Choice to save a companion (text + loop)
        % Ending #8: %The Hard Choice

        % One of the case statements that has a different format.  The
        % beginning still has a runLevel, fprintf's, and a choice.  However
        % if you choose to save Tyler there will be a fight.  
        % A (1x5) matrix is created and displayed for 1.5 seconds, afterwords
        % the user will have to type the numbers of the matrix.  This is
        % completed through a loop that runs for the length of the matrix.
        % In the loop there is an if-else statement, if the user inputed
        % number and the number in the loop do not corelate mess up will be
        % set to true, when the loop is over depending on the state of
        % messUp, a different ending will be played. 
        % since getKeyboardInput uses ascii values, the integer in the
        % matrix has to be converted from a number to a string to ascii
        % value for the comparison to work.
        case 12
            clc;
            runLevel(zomboid,'alleyCompInsideZombies.txt')
            fprintf('The zombies out front must have heard the commotion and have been banging on the front door and\n')
            fprintf('the windows ever since. The window is beginning to steadily crack. You begin looking for a way out and\n')
            fprintf('notice a lock on a??third entrance behind the counter??that leads to the other side of the store, but the key\n')
            fprintf('is nowhere to be found. As you look around, suddenly you hear the window shatter, and the zombies\n')
            fprintf('begin flooding in. You see the undead going for Tyler and Alex at the same time. You can only save one\n\n')
            fprintf(' [\ba.)   Save Tyler\n')
            fprintf(' b.)   Save Alex]\b\n')
            
            while isequal(companionChoice,'default')
                companionChoice = getKeyboardInput(zomboid);
                if isequal(companionChoice,'a')
                    fprintf('You decide that you must save Tyler considering he has done the same for you. You take your machete\n')
                    fprintf('and kill the zombies behind him. You hear Alex scream but there is nothing you can do. You and Tyler\n')
                    fprintf('rush to the back of the store where the locked entrance is. You break the lock with your machete and\n')
                    fprintf('escape the store. You block the entrance behind you by sliding a pipe lying on the ground through the\n')
                    fprintf('handles. You look around and realize nightfall will come before the end of the hour. Not enough time to\n')
                    fprintf('make it out on foot. You then realize there is a bicycle lying in the street. You begin to walk for it until\n')
                    fprintf('Tyler stops you. He says he is taking it and you can???t stop him. You continue to go for the bike, but Tyler\n')
                    fprintf('says he is not afraid to kill you for it. He then rushes toward you to attack.\n\n')
                    fprintf('Time seems to slow as you Tyler approaches. You realize that you will have to quickly recognize the moves\n')
                    fprintf('he is about to make and respond appropriately.\n\n')
                    fprintf('Press any key to continue')
                    runLevel(zomboid,'alleyCompInsideZombiesSave.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSave.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape2.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape3.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape4.txt')
                    getMouseInput(zomboid);
                    clc;
                    fprintf('Luckily you have been preparing for this moment all your life.  You have a bunch of martial art moves all\n')
                    fprintf('numbered and are prepared to use them as soon as you Tyler makes a move\n\n')
                    fprintf('Type the sequence of numbers you see to win the fight, <strong>only start after the numbers dissapear</strong>')
                    fprintf('press any key to continue')
                    getMouseInput(zomboid);
                    clc;
                    martialArts = randi(9,1,5);
                    disp(martialArts)
                    pause(1.5);
                    clc;
                        messUp = false;
                        for i = 1:length(martialArts)
                            checkMartial = martialArts(i);
                            checkMartial = num2str(checkMartial);
                            checkMartial = unicode2native(checkMartial);
                            fightMove = getKeyboardInput(zomboid);
                            if fightMove ~= checkMartial
                                messUp = true;
                            end
                        end
                    if messUp == true
                        saveFile{1}(9) = 1;
                        fprintf('You must have used the wrong move and lose the battle\n\n')
                        fprintf(2,'You Died \n\n')
                        fprintf('\n\npress any key to continue')
                        getMouseInput(zomboid);
                    else
                        saveFile{1}(10) = 1;
                        fprintf('You preform better than you could have hoped, you quickly hop on the bike and pedal to safety\n\n')
                        fprintf('press any key to continue')
                        runLevel(zomboid,'beatTyler1.txt')
                        getMouseInput(zomboid);
                    end
                    
                    stage = 0;
                elseif isequal(companionChoice,'b')
                    runLevel(zomboid,'alleyCompInsideZombiesSave.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSave.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape1.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape2.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape3.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape4.txt')
                    pause(.5)
                    runLevel(zomboid,'alleyCompDeadInsideZombiesSaveEscape5.txt')
                    fprintf('You leap towards Alex and kill approaching zombies with your machete. You quickly glance towards\n')
                    fprintf('Tyler and see him be eaten while he looks you dead in the eye. You and Alex rush to the back of the\n')
                    fprintf('store where the locked entrance is. You begin hitting the lock with your machete. It seems that you\n')
                    fprintf('won''t get through it in time until it suddenly breaks, allowing you to escape to the backside of the store.\n')
                    fprintf('You block the entrance behind you by sliding your machete through the handles. You tell Alex that you\n')
                    fprintf('both need to get moving when she points out a car on the street. She then pulls out a pair of\n')
                    fprintf('keys and says she found them behind the counter earlier that day. You both get in and drive away.\n')
                    getMouseInput(zomboid);
                    saveFile{1}(8) = 1;
                    stage = 0;
                else 
                    companionChoice = 'default';
                end
            end
        
        % Enter Secret Code
        % This is another case that is different from the usual.  It starts
        % with runLevel and some fprintfs depending on whether or not
        % Companion1 is true.  If it isn't you die, if it is you enter a
        % secret room.  There more fprinf statements are shown explaining
        % that you have to type a code into a panel.  From there a new
        % runLevel is used (with a different game object so it opens a new
        % window).  The new level consists of numbers 0-9 and a x and o.
        % From there is then a loop that will run as long as the player
        % doesn't click on the o. The numbers clicked on are gotten through
        % getMouseInput.  That value is then converted with the Indexer
        % function set to work with the how the simpleGameEngine indexes
        % things (left to right, top to bottom instead of top to bottom,
        % left to right).  After the user presses o, there is an if else
        % statement that checks to see if 1181 chosen as the code. If it
        % was an ending is triggered, if it wasn't the character will go
        % back to the previous path.  As a note, because of the way that
        % the loop is set up the last value in panelCode is the index of o,
        % so the if statement is only triggered if length(panelCode) = 5
        % (meaning the user typed 4 numbers + o) & if it is equal to  the
        % index of 1181 (9929).  Note: This case statement is not in
        % chronilogical order, but it doesn't change how it works.
        
        case 14
            clc;
            if companion1 == true
                runLevel(zomboid,'roadComp2Sewers1.txt')
                pause(.5)
                runLevel(zomboid,'roadComp2Sewers2.txt')
                pause(.7)
                fprintf('You move for the sewers and climb down the manhole with Tyler right behind you. The stench is\n')
                fprintf('horrible, but you still push forward. You walk down the path believing that this was the best choice until\n')
                fprintf('the sewers begin to fork into separate paths. With no other street access points in sight, you just make\n')
                fprintf('turn after turn until you are completely lost. Tyler panics behind you. You pass by a door that has two\n')
                fprintf('zombies in front of it. Do you choose to fight them or rush past them and continue through the sewers?\n\n')
                runLevel(zomboid,'sewersComp1.txt')
            else
                runLevel(zomboid,'road2Sewers1.txt')
                pause(.5)
                runLevel(zomboid,'road2Sewers2.txt')
                pause(.7)
                fprintf('You move for the sewers and climb down the manhole.??The stench is horrible, but you still push\n')
                fprintf('forward. You walk down the path believing that this was the best choice until the sewers begin to fork\n')
                fprintf('into separate paths. With no other street access points in sight, you just make turn after turn until you')
                fprintf('are completely lost. You begin to feel anxious. You pass by a door that has two zombies in front of it. Do\n')
                fprintf('you choose to fight them or rush past them and continue through the sewers?\n\n')
                runLevel(zomboid,'sewers1.txt')
            end
            fprintf( '[\b a.)   Fight\n')
            fprintf(' b.)   Continue]\b\n\n')
            while isequal(panelDecision,'default')
                panelDecision = getKeyboardInput(zomboid);
                if isequal(panelDecision,'a')
                    if companion1 == true
                        fprintf('You and Tyler attack the zombies with your weapons and execute them. You open the door which leads\n')
                        fprintf('to a room with several computer terminals and servers. You are completely confused. You approach a\n')
                        fprintf('terminal that is already on. It simply reads ???Input Password:???\n\n')
                        runLevel(zomboid,'sewersComp1Fight1.txt')
                        pause(.5)
                        runLevel(zomboid,'sewersComp1Fight2.txt')
                        pause(.5)
                        runLevel(zomboid,'sewersComp1Fight3.txt')
                        pause(.5)
                        runLevel(zomboid,'sewersComp1Fight4.txt')
                        pause(.5)
                        runLevel(zomboid,'sewersPanelRoom1.txt')
                        pause(.5)
                        runLevel(zomboid,'sewersPanelRoom2.txt')
                        pause(.5)
                        runLevel(zomboid,'sewersPanelRoom3.txt')
                        fprintf('press any key to continue')
                        getMouseInput(zomboid);
                        clc;
                        runLevel(secretPanel,'panel.txt')
                        panelCode = [];
                        panelChoice = 0;
                        while panelChoice ~= 15
                            [rowVal,columnVal] = getMouseInput(secretPanel);
                            panelChoice = indexer([4,3],rowVal,columnVal,1);
                            panelCode(end+1) = panelChoice;
                        end
                        close
                        if length(panelCode) == 5 & panelCode(1:end-1) == [9 9 2 9]
                            fprintf('You input the code. The terminal reads ???Correct Password.??? The screen then changes to a complicated\n')
                            fprintf('screen with a U.S. Army logo on it. There are numerous files and controls, but one sticks out to you,\n')
                            fprintf('???Abort nuclear launch.??? You press it. The terminal reads: ???Nuclear Launch aborted. ???You are\n')
                            fprintf('dumbfounded. All you hear is Tyler say, ???Holy shit.???\n\n')
                            fprintf('press any key to continue')
                            getMouseInput(zomboid);
                            stage = 0;
                            saveFile{1}(29) = 1;
                        else
                            fprintf('The panel flashes red and promptly shuts off, you have no choice but continue along the sewers\n\n')
                            runLevel(zomboid,'sewersPanelRoom2.txt')
                            pause(.5)
                            runLevel(zomboid,'sewersPanelRoom1.txt')
                            pause(.5)
                            runLevel(zomboid,'sewersComp1Fight4.txt')
                            fprintf('Press any key to continue')
                            getMouseInput(zomboid)
                            stage = 17;
                        end
                    else
                        runLevel(zomboid,'sewers1Fight1.txt')
                        pause(.5)
                        runLevel(zomboid,'sewers1Fight2.txt')
                        pause(.5)
                        runLevel(zomboid,'sewers1Fight3.txt')
                        fprintf('You ball your fists and punch the first zombie in the head. The other zombie grabs your arm and bites it.\n')
                        fprintf('In hindsight, attacking without a weapon was probably not a good idea.\n\n')
                        fprintf(2,'You Died \n\n')
                        fprintf('Press any key to continue')
                        getMouseInput(zomboid);
                        stage = 0;
                        saveFile{1}(12) = 1;
                    end
                elseif isequal(panelDecision,'b')
                    if companion1 == true
                        fprintf('You and Tyler decide it is not worth the danger and continue on your path\npress any key to continue')
                    else
                        fprintf('You decide it is not worth the danger and continue on your path\npress any key to continue')
                    end
                    getMouseInput(zomboid);
                    stage = 17;
                else
                    panelDecision = 'default';
                end
            end
        
        % Choice how to deal with bandit blockade (text + loop)
        % Ending #11: Best Friends
        % Ending #12: Don't Fight Alone
        %   Hint to need a companion
        case 15
            clc;
            if companion1 == true
                runLevel(zomboid,'roadComp1.txt')
                pause(.5)
                runLevel(zomboid,'roadComp2.txt')
                fprintf('You decide it is best to take the street, believing going by alley will be too slow.  As Tyler and you make\n')
                fprintf('your way down the street, you look for another vehicle you both can take to escape. As you crest a hill\n')
                fprintf('you both notice something bizarre.  There was a line of crashed cars blocking the street and a group of\n')
                fprintf('people with guns standing around the blockade. They looked like bandits and will most likely respond\n')
                fprintf('aggressively if provoked. How should you respond?\n\n')
            else
                runLevel(zomboid,'road1.txt')
                pause(.5)
                runLevel(zomboid,'road2.txt')
                fprintf('You decide it is best to take the street, believing going by alley will be too slow.????As you make your way\n')
                fprintf('down the street,??you look for another vehicle you??can take to escape. As you crest a hill you notice\n')
                fprintf('something bizarre.????There was a line of crashed cars blocking the street and a group of people with guns\n')
                fprintf('standing around the blockade. They looked like bandits and will most likely respond aggressively if\n')
                fprintf('provoked. How should you respond?\n\n')
            end
            fprintf(' [\ba.)   sneak past\n')
            fprintf(' b.)   fight]\b\n\n')
            while isequal(banditBlockade,'default')
               banditBlockade = getKeyboardInput(zomboid);
               if isequal(banditBlockade,'b') && companion1 == true
                   fprintf('Tyler and you approach the group of bandits which you now can tell is only 4 men. When you approach,\n')
                   fprintf('they point their guns at the two of you and tell you to give them anything you have. Tyler refuses and\n')
                   fprintf('one them puts his gun right to Tyler???s forehead, and asks again with more confidence. In a flash Tyler\n')
                   fprintf('pulls his own gun out and shoots the bandit chest twice, and then shoots the guy standing behind him\n')
                   fprintf('too. Almost instinctively you cut through the bandit in front of you with your machete before he can\n')
                   fprintf('comprehend the situation. You then realize the last bandit is ready to shoot Tyler. Right before he is able\n')
                   fprintf('to you tackle him saving Tyler???s life. Tyler then shoots him. ???Thanks man??? Tyler says. You take one of the\n')
                   fprintf('bandits working cars behind the blockade, and drive out of the city with Tyler.\n\n')
                   runLevel(zomboid,'roadBanditCompFight1.txt')
                   pause(.5)
                   runLevel(zomboid,'roadBanditCompFight2.txt')
                   pause(.5)
                   runLevel(zomboid,'roadBanditCompFight3.txt')
                   fprintf('Press any key to continue')
                   getMouseInput(zomboid)
                   saveFile{1}(11) = 1;
                   stage = 0;
               elseif isequal(banditBlockade,'b')
                    fprintf('You walk directly down the street towards the group of bandits ready to either talk your way through or\n')
                    fprintf('get by with force.  As soon as you get in the groups sight, they point their guns at you. ???Give me all your\n')
                    fprintf('belongings.??? the man in front orders. You tell him you have nothing. They all open fire.\n\n')
                    runLevel(zomboid,'roadBanditFight1.txt')
                    pause(.5)
                    runLevel(zomboid,'roadBanditFight2.txt')
                    pause(.5)
                    runLevel(zomboid,'roadBanditFight3.txt')
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid)
                    stage = 0;
                    saveFile{1}(12) = 1;
               elseif isequal(banditBlockade,'a')
                   stage = 16;
               end
            end
        
        % How do you want to sneak around the bandits? (text + loop)
        % Ending #13: Not That Dangerous
        %   Because even a cornered rat can be dangerous, but it turns out
        %   that you weren't that dangerous.
        case 16
            clc;
            fprintf('You make the decision it is probably smarter to sneak and avoid conflict. You look to the side and notice\n')
            fprintf('buildings you think you could sneak through to get around. You also observe that a manhole is open on\n')
            fprintf('the street. You could go through the sewers and pop up on the other side. Which way?\n\n')
            fprintf(' [\ba.)   Go into buildings\n')
            fprintf(' b.)   Go into the sewers]\b\n\n')
            while isequal(banditSneak,'default')
                banditSneak = getKeyboardInput(zomboid);
                if isequal(banditSneak,'a')
                    fprintf('You make a break for the buildings near the blockade, and are able to get inside with the bandits on the\n')
                    fprintf('street noticing you. When you go through the door you walk straight into a big rough looking man. Oh\n')
                    fprintf('no another bandit. He raises his gun and shoots\n\n')
                    if companion1 == true
                        runLevel(zomboid,'building1Comp.txt')
                        pause(.5)
                        runLevel(zomboid,'building2Comp.txt')
                        pause(.5)
                        runLevel(zomboid,'building3Comp.txt')
                        pause(.5)
                        runLevel(zomboid,'building4Comp.txt')
                        pause(.5)
                        runLevel(zomboid,'building5Comp.txt')
                    else
                        runLevel(zomboid,'building1.txt')
                        pause(.5)
                        runLevel(zomboid,'building2.txt')
                        pause(.5)
                        runLevel(zomboid,'building3.txt')
                        pause(.5)
                        runLevel(zomboid,'building4.txt')
                        pause(.5)
                        runLevel(zomboid,'building5.txt')
                    end
                    fprintf(2, 'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid)
                    stage = 0;
                    saveFile{1}(13) = 1;
                elseif isequal(banditSneak,'b')
                    stage = 14;
                else 
                    banditSneak = 'default';
                end
            end
        
        % Do you save dog (text + loop)
        % Ending #14: Mans Best Friend
        % Ending #15: Misothery
        %   Because Misothery means contempt for animals
        % Ending #16: Bring Some Bandaids Maybe?
        case 17
            clc;
            fprintf('You begin walking for what begins to feel like an eternity. The reality of the situation sets in. You are\n')
            fprintf('completely lost. Right before you give up, you see something weird. There is a dog that appears to be\n')
            fprintf('injured. You have no idea how it could have gotten here, but it is.\n')
            if haveFirstAidKit == true
                runLevel(zomboid,'sewersWalk1.txt')
                pause(.5)
                runLevel(zomboid,'sewersWalk2.txt')
                pause(.5)
                runLevel(zomboid,'sewersWalk3.txt')
                pause(.5)
                runLevel(zomboid,'sewersWalk4.txt')
                fprintf(' Do you use your first aid kit to save it?\n\n')
                fprintf(' [\ba.)   Save dog\n')
                fprintf(' b.)   Don''t save dog ]\b\n\n')
                while isequal(dogSave,'default')
                    dogSave = getKeyboardInput(zomboid);
                    if isequal(dogSave,'a')
                        fprintf('You put bandage on the dog''s side that has a deep cut in it. It springs to life and licks you happily. It then\n')
                        fprintf('begins to walk down the sewer path, but stops to look back at you like it wants you to follow it. You\n')
                        fprintf('begin to follow the dog. It takes you turn after turn like it knows exactly where it is going. You eventually\n')
                        fprintf('see a light. You emerge from the sewer into an outlet a few miles outside the city. The dog led you away.\n')
                        fprintf('What a good boy.\n\n')
                        for i = 1:3
                            runLevel(zomboid,'sewersWalk4.txt')
                            pause(.5)
                            runLevel(zomboid,'sewersWalk5.txt')
                            pause(.5)
                            runLevel(zomboid,'sewersWalk6.txt')
                            pause(.5)
                        end
                        runLevel(zomboid,'sewersWalk7.txt')
                        fprintf('press any key to continue')
                        getMouseInput(zomboid);
                        saveFile{1}(14) = 1;
                        stage = 0;
                    elseif isequal(dogSave,'b')
                        fprintf('You choose the save the first aid kit for yourself in case you need it. You walk down the sewers making\n')
                        fprintf('turn after turn. You are stuck down here. The nuke shortly hits and you perish.\n\n')
                        for i = 1:5
                            runLevel(zomboid,'sewersInf1.txt')
                            pause(.5)
                            runLevel(zomboid,'sewersInf2.txt')
                            pause(.5)
                            runLevel(zomboid,'sewersInf3.txt')
                            pause(.5)
                        end
                        fprintf(2, 'You Died \n\n')
                        fprintf('Press any key to continue')
                        getMouseInput(zomboid);
                        saveFile{1}(15) = 1;
                        stage = 0;
                    else
                        dogSave = 'default';
                    end
                end
            else
                if companion1 == true
                    runLevel(zomboid,'sewersCompWalk1.txt')
                    pause(.5)
                    runLevel(zomboid,'sewersCompWalk2.txt')
                    pause(.5)
                    runLevel(zomboid,'sewersCompWalk3.txt')
                    fprintf('You can''t help the dog, having already used your first aid kit on Tyler, you have no choice but to wait for\n')
                    fprintf('the end with the dog.\n\n')
                else
                    runLevel(zomboid,'sewers1.txt')
                    pause(.5)
                    runLevel(zomboid,'sewersWalk1.txt')
                    pause(.5)
                    runLevel(zomboid,'sewersWalk2.txt')
                    pause(.5)
                    runLevel(zomboid,'sewersWalk3.txt')
                    pause(.5)
                    runLevel(zomboid,'sewersWalk4.txt')
                    fprintf('You can''t save the dog, lost you have no other choice but wait for the end with the dog.\n\n')
                end
                fprintf(2,'You Died \n\n')
                fprintf('Press any key to continue')
                getMouseInput(zomboid);
                stage = 0;
                saveFile{1}(16) = 1;
            end
        
        % Which river branch do you choose to go down (text + loop)
        % Ending #17: Inevitable Waterfall
        case 18
            clc
            runLevel(zomboid,'crossroadsBoat1.txt')
            pause(.5)
            runLevel(zomboid,'crossroadsBoat2.txt')
            pause(.5)
            runLevel(zomboid,'crossroadsBoat3.txt')
            fprintf('You decide to take the boat down the river. Walking would take too long, and the car may attract\n')
            fprintf('unwanted attention.  Unfortunately, none of the boats had the keys left in them, but one of them had\n')
            fprintf('an emergency raft. You considered your situation an emergency, threw it in the water and started\n')
            fprintf('flowing downstream. You noticed there is a branch in the path, which one do you take?\n\n')
            fprintf(' [\ba.)   Branch 1\n')
            fprintf(' b.)   Branch 2]\b\n\n')
            while isequal(boatBranch,'default')
                boatBranch = getKeyboardInput(zomboid);
                if isequal(boatBranch,'a')
                    fprintf('As you continue to float down the river you hear a quiet sound of what appears to be falling water.\n')
                    fprintf('You think nothing of it, but it keeps on getting louder until you realize its a waterfall.  Terror\n')
                    fprintf('slowly builds as you get closer and closer, but there is nothing you can do. You scream as you tumble\n')
                    fprintf('over the falls\n\n')
                    runLevel(zomboid,'falls1.txt')
                    pause(.5)
                    runLevel(zomboid,'falls2.txt')
                    pause(.5)
                    runLevel(zomboid,'falls3.txt')
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(17) = 1;
                elseif isequal(boatBranch,'b')
                    stage = 19;
                else
                    boatBranch = 'default';
                end
            end
        % What do you do to survive rough waters (text + loop)
        % Ending #18: There weren't even Sharks
        case 19 
            clc
            runLevel(zomboid,'saveBranch1.txt')
            pause(.5)
            runLevel(zomboid,'safeBranch2.txt')
            fprintf('You decide to paddle towards the second branch.\n')
            fprintf('The ride was nice and smooth for the first bit, but it gradually started getting\n')
            fprintf('rougher until you were in full blown rapids. You raft was not handling it well and you felt it was going to tip\n')
            fprintf('soon. What do you do?\n\n')
            fprintf(' [\ba.)   Swim for the shore\n')
            fprintf(' b.)   Brace for impact]\b\n\n')
            while isequal(roughWater,'default')
                roughWater = getKeyboardInput(zomboid);
                if isequal(roughWater,'a')
                    fprintf('You jump out and decide to swim for land, but the current is strong. You are barely staying above\n')
                    fprintf('surface. You hit a rock and go under completely. If only you had a life jacket. \n\n')
                    runLevel(zomboid,'roughSwim1.txt')
                    pause(.5)
                    runLevel(zomboid,'roughSwim2.txt')
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(18) = 1;
                elseif isequal(roughWater,'b')
                    stage = 20;
                else
                    roughWater = 'default';
                end
            end
        
        % What do you do with the damaged raft (text + loop)
        % Ending #19: SOS
        case 20
            clc;
            runLevel(zomboid,'roughDecision1.txt')
            pause(.5)
            runLevel(zomboid,'roughDecision2.txt')
            fprintf('You duck into the raft and brace for impact. The raft bounces around the river until it crashes into a\n')
            fprintf('large rock and you pass out. You wake up on the raft sometime later in calm water. There is debris all\n')
            fprintf('around you, and your paddle is missing. You have no idea how long you were passed out, but it is getting\n')
            fprintf('dangerously close to night fall and you are not far away enough from the city. To make matter worse, the\n')
            fprintf('current is pretty much nonexistent. What do you do?\n\n')
            fprintf(' [\ba.)   Use debris to paddle\n')
            fprintf(' b.)   Call for help\n')
            fprintf(' c.)   Swim to shore]\b\n\n')
            while isequal(brokenBoat,'default')
                brokenBoat = getKeyboardInput(zomboid);
                if isequal(brokenBoat,'a')
                    fprintf('You reach into the water and grab a piece of wooden debris and start paddling. You do your best to gain\n')
                    fprintf('speed but the piece of debris might as well have been useless. Your time runs out and you perish by\n')
                    fprintf('nuclear explosion.\n\n')
                    runLevel(zomboid,'debri.txt')
                    fprintf(2,'You Died ')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0; 
                    saveFile{1}(19) = 1;
                elseif isequal(brokenBoat,'b')
                    weapon = 'none';
                    stage = 21;                    
                elseif isequal(brokenBoat,'c')
                    stage = 23;
                else
                    brokenBoat = 'default';
                end
            end
        
        % How do you fight the zombie (text + loop)
        % Ending #20: I used to be a human, then I took a bite too the knee
        %   I took an arrow to the knee
        % Ending #21: Who left that there?
        %   You trip on a banana that a bandit threw at your feet
        case 21
            clc;
            runLevel(zomboid,'boatCall.txt')
            pause(.5)
            runLevel(zomboid,'banditBoat1.txt')
            pause(.5)
            runLevel(zomboid,'banditBoat2.txt')
            pause(.5)
            runLevel(zomboid,'banditBoat3.txt')
            pause(.5)
            runLevel(zomboid,'banditBoat4.txt')
            fprintf('You feel you are out of options and begin screaming for help. In the horizon a small boat comes by and\n')
            fprintf('heads your way. However, when the boat comes next to your raft, the men aboard look aggressive, and\n')
            fprintf('dangerous. They pull you aboard and take all of your belongings. This group of bandits then throw you\n')
            fprintf('down on the deck of the boat. They tell you your life is theirs now and they want you to play a game.\n')
            fprintf('They then pull up a zombie from below the ship on a leash, and release it in front of you. ???Fight this\n')
            fprintf('zombie, if you survive, we will let you go.??? The zombie lunges for you. How do you react?\n\n')
            fprintf(' [\ba.)   kick it\n')
            fprintf(' b.)   Try and escape\n')
            fprintf(' c.)   Attack the bandits]\b\n\n')
            while isequal(banditZombieFight,'default')
                banditZombieFight = getKeyboardInput(zomboid);
                if isequal(banditZombieFight,'a')
                    fprintf('You attempt to kick the zombie in the head, but as you do it bites your knee. The zombie then continues\n')
                    fprintf('past your leg, and bites your neck.\n\n')
                    runLevel(zomboid,'banditBoat4Dead.txt')
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(20) = 1;
                elseif isequal(banditZombieFight,'b')
                    fprintf('You attempt to sprint by the bandits and jump into the river, but instantly the one of the bandits throws\n')
                    fprintf('his banana at your feet, you trip and fall.  The bandits close in.\n\n')
                    runLevel(zomboid,'banditBoat4Run1.txt')
                    pause(.5)
                    runLevel(zomboid,'banditBoat4Run2.txt')
                    pause(.5)
                    runLevel(zomboid,'banditBoat4Run3.txt')
                    fprintf(2,'You Died \n\n')
                    fprintf('press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(21) = 1;
                elseif isequal(banditZombieFight,'c')
                    stage = 22;
                else
                    banditZombieFight = 'default';
                end
            end
        
        % Do you join the bandits (text + loop)
        % Ending #22: Straight up G
        case 22
            clc;
            runLevel(zomboid,'banditBoat4Exchange.txt')
            pause(.5)
            runLevel(zomboid,'banditBoat4Exchange2.txt')
            fprintf('You grab one of the bandits surrounding you and the zombie, and before he can react, you throw him at\n')
            fprintf('the zombie. The zombie begins eating the bandit, and completely ignore you. Despite the bloodcurdling\n')
            fprintf('screams, you approach the scene and finish the zombie off by stomping it with your boot. You then hear\n')
            fprintf('clapping. You turn to see that the bandit that seems to be the leader is applauding you. ???That was\n')
            fprintf('something else,??? he says. ???I like your style.??? The leader introduces himself as <strong>Chris</strong>, and the other two\n')
            fprintf('living bandits as <strong>Shreyas</strong> and <strong>Kevin</strong>. He then asks you to stick with them. What do you say?\n\n')
            fprintf(' [\ba.)   Accept Bandits offer\n')
            fprintf(' b.)   Decline Bandits offer]\b\n\n')
            while isequal(banditOffer,'default')
                banditOffer = getKeyboardInput(zomboid);
                if isequal(banditOffer,'a')
                    fprintf('Chris gives smiles and gives you your stuff back, and shakes your hand firmly. You spend the next few\n')
                    fprintf('hours waiting outside the city waiting for people to leave. You rob and kill them for their supplies.\n')
                    fprintf('Survivors fear you and you love the power.\n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    saveFile{1}(22) = 1;
                    stage = 0;
                elseif isequal(banditOffer,'b')
                    stage = 23;
                else
                    banditOffer = 'default';
                end
            end
        
        % Do you help the community (text + loop)
        case 23
            clc;
            if isequal(banditOffer,'b')
                runLevel(zomboid,'noBandit1.txt')
                pause(.5)
                runLevel(zomboid,'noBandit2.txt')
                fprintf('"Thats to bad.??? Chris says sinisterly. He then kicks you hard in the chest, and you fall into the water.\n')
            else
                runLevel(zomboid,'roughDecision2Swim.txt')
            end
            runLevel(zomboid,'community1.txt')
            pause(.5)
            runLevel(zomboid,'community2.txt')
            fprintf('You swim for land, and reach the shore out of breath. You are nowhere near far enough away from the\n')
            fprintf('city. You walk to a nearby community near in the residential part of the city that is nearby. You hope to\n')
            fprintf('find a car or something to get away quickly. However, all you find is that all of the residents, families\n')
            fprintf('with children, are gathered together in a nearby park. They look scared and hopeless. You approach and\n')
            fprintf('a woman who appears to be in charge comes to you. She introduces herself as <strong>Autumn</strong> and tells you\n')
            fprintf('that the community cannot escape because a large horde of zombies is blocking the bridge that is the\n')
            fprintf('only way out of the city. She says she knows you have no reason to, but begs for your help. What do you do\n\n')
            fprintf(' [\ba.)   Help them\n')
            fprintf(' b.)   Carry on your way]\b\n\n')
            while isequal(communityChoice,'default')
                communityChoice = getKeyboardInput(zomboid);
                if isequal(communityChoice,'a')
                    stage = 24;
                elseif isequal(communityChoice,'b')
                    stage = 25;
                else
                    communityChoice = 'default';
                end
            end
        
        % How do you deal with the zombie horde (text + loop)
        % Ending #23: Charge!!!
        % Ending #24: Hero to the People
        case 24
            clc;
            fprintf('You tell her you will do what you can, and walk towards the bridge. When you get there, you see at least\n')
            fprintf('a hundred zombies gathered. Right before the bridge there is a car that was left with the key in inside.\n')
            fprintf('You go inside and start the engine. How do you deal with the horde?\n\n')
            runLevel(zomboid,'communityHelp1.txt')
            pause(.5)
            runLevel(zomboid,'communityHelp2.txt')
            pause(.5)
            runLevel(zomboid,'communityHelp3.txt')
            pause(.5)
            runLevel(zomboid,'communityHelp4.txt')
            pause(.5)
            runLevel(zomboid,'communityHorde.txt')
            fprintf(' [\ba.)   Drive straight through the horde\n')
            fprintf(' b.)   Distract the hoard]\b\n\n')
            while isequal(communityZombieHoard,'default')
                communityZombieHoard = getKeyboardInput(zomboid);
                if isequal(communityZombieHoard,'a')
                    fprintf('You drive full speed into the horde hoping to kill the large majority of them, but as soon as you hit the\n')
                    fprintf('horde, the car stops almost immediately. The dozens of corpses acted like a brick wall. Your car is\n')
                    fprintf('surrounded, and you are killed\n\n')
                    runLevel(zomboid,'communityHordeCharge1.txt')
                    pause(.5)
                    runLevel(zomboid,'communityHordeCharge2.txt')
                    pause(.5)
                    runLevel(zomboid,'communityHordeCharge3.txt')
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(23) = 1;
                elseif isequal(communityZombieHoard,'b')
                   fprintf('You honk the horn and get the hordes attention. You begin to drive away slowly as they follow. You get\n')
                   fprintf('a few miles away when the car engine quits on you. You weren???t able to drive away and now the\n')
                   fprintf('zombies are to close. You attempt to run away, but one grabs you and bites you on the arm. You pull\n')
                   fprintf('free and run. You get far enough away that the horde loses you, but it doesn???t change the fact you are\n')
                   fprintf('bit. You look down the river to see that the community is safely crossing the bridge. At least it wasn''t in\n')
                   fprintf('vain. The community members are able to escape the city and vow to never forget your sacrifice. You lay\n')
                   fprintf('against a tree, and watch as the nuke hits your city.\n\n')
                   runLevel(zomboid,'communityHordeDistract1.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHorde.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract2.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract3.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract4.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract5.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract6.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract7.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract8.txt')
                   pause(.5)
                   runLevel(zomboid,'communityHordeDistract9.txt')
                   fprintf('Press any key to continue')
                   getMouseInput(zomboid);
                   stage = 0;
                   saveFile{1}(24) = 1;
                else
                    communityZombieHoard = 'default';
                end
            end
            
        % Last path (text + loop)
        % ending #24: Cold Blooded
        % ending #25: Well, what difference does it make
        %   Because you are rude and left the group of people to fend for
        %   themselves, so you are so immoral you are practically already
        %   not human, what difference does becoming a zombie make.
        % ending #26: No Escape
        case 25
            clc;
            runLevel(zomboid,'community2.txt')
            pause(.5)
            runLevel(zomboid,'communityHelp1.txt')
            pause(.5)
            runLevel(zomboid,'communityAbandon1.txt')
            pause(.5)
            runLevel(zomboid,'communityAbandon2.txt')
            fprintf('You decide that helping these people would be a waste of time and just end up with everyone dead.\n')
            fprintf('You ignore their pleas and continiue on your way.  You reach the outskirts of the city soon however\n')
            fprintf('blocking your way is a small amount of zombies.  Do you rish fighting them or try to find another way\n\n')
            fprintf(' [\ba.)   Fight the zombies\n')
            fprintf(' b.)   Find another way out]\b\n\n')
            while isequal(finalZombies,'default')
                finalZombies = getKeyboardInput(zomboid);
                if isequal(finalZombies,'a') && ~isequal(weapon,'none')
                    runLevel(zomboid,'communityAbandon2Fight1.txt')
                    pause(.5)
                    runLevel(zomboid,'communityAbandon2Fight2.txt')
                    fprintf('You kill the zombie and escape\n\n')
                    fprintf('Press any button to continue')
                    getMouseInput(zomboid);
                    % win = 'Cold Blooded';
                    stage = 0;
                    saveFile{1}(25) = 1;
                elseif isequal(finalZombies,'a')
                    runLevel(zomboid,'communityAbandon2Fight1.txt')
                    pause(.5)
                    runLevel(zomboid,'communityAbandon2Fight1Dead.txt')
                    fprintf('You charge towards the zombies, but unfortunately without a weapon you can not kill the zombies\n\n')
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(26) = 1;
                elseif isequal(finalZombies,'b')
                    fprintf('You decide it is not worth the risk to fight the zombies and continue to try another way out of the city\n')
                    fprintf('Originally you weren''t worried about getting away, but as time continued and you coulnd''t leave you\n')
                    fprintf('realized you made a mistake.\n\n')
                    runLevel(zomboid,'communityAbandon2Walk1.txt')
                    pause(.5)
                    runLevel(zomboid,'communityAbandon2Walk2.txt')
                    pause(.5)
                    runLevel(zomboid,'communityAbandon2Walk3.txt')
                    pause(.5)
                    runLevel(zomboid,'communityAbandon2Walk4.txt')
                    pause(.5)
                    fprintf(2,'You Died \n\n')
                    fprintf('Press any key to continue')
                    getMouseInput(zomboid)
                    stage = 0;
                    saveFile{1}(27) = 1;
                else
                    finalZombies = 'default';
                end
            end        
    end       
end
clc;


% this checks if the user ran out of time
% ending: Slow Poke
if timeLeft <= 0
    saveFile{1}(28) = 1;
end

% Prints the endings.  When an ending is achieved in the main game loop
% saveFile{1}(i) is set to 1, where i corresponds to the number ending
% (If you got ending number 5 there would be a saveFile{1}(5) = 1;). In the
% loop if the ending was achieved, it will print it to the screen other
% wise it would print a bunch of question marks.  If the ending was one
% where the character successfully escapaed the ending is printed in
% orange, otherwise (if they died) it is printed in red.
for i = 1:29
    if saveFile{1}(i) == 1
        if sum(i == [8,10,11,14,22,25,29]) == 1
            fprintf('[\b%s]\b\n',endings{i,1});
        else
            fprintf(2,'%s \n',endings{i,1});
        end
    else
        fprintf('%s\n',endings{30,1})
    end
end

% VERY IMPORTANT the clock is stopped and deleted.  If the code errors/ is stopped
% early this line will not have been run and needs to be run manually in
% the command window before the workspace is cleared. Otherwise the clock
% will sort of still exist and will try to run a function that does not
% exist every second.
stop(gameClock);
delete(gameClock);
% allows for the player to exit or play again, if they play again the
% program will run again, however since playAgain now exists it will no
% longer prompt the user for a saveFile.  Otherwise the saveFile will be
% printed to screen.  There is an unusual quirk where in MATLAB R2021b
% instead of printing '1' it will print ' ' in previous versions it would
% print '???'.
fprintf('\n\nPress ENTER to play again\nPress ESC to exit')
playAgain = getKeyboardInput(zomboid);
if isequal(playAgain,'return')
    Zomboid3
else
    clc;
    fprintf('Here is your save file, be sure to copy it.  Don''t forget the spaces\n')
    savefile = saveFile{1}
    close all; clear
end