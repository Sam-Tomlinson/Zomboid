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
    definput = {'00000000000000000000000000000'};
    saveFile = inputdlg(prompt,dlgTitle,numlines,definput);
end
    
    
% Start stuff
clc; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5);
numberIndex = load('numberIndex.txt');
numberStr = load('numberStr.txt');
endings = readcell('endings.txt');
timeLeft = 300;
gameClock = timer('ExecutionMode','FixedRate');
set(gameClock,'TimerFcn','timeLeft = gameTimer2(timeLeft,numberIndex,numberStr,clock);');

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
dogSave = 'default';
boatBranch = 'default';
roughWater = 'default';
brokenBoat = 'default';
banditZombieFight = 'default';
banditOffer = 'default';
comunityChoice = 'default';
communityZombieHoard = 'default';
finalZombies = 'default';


    

    

%Debug stuff
runLevel(zomboid,'startCard.txt')
gameFigure = get(groot,'CurrentFigure');
movegui(gameFigure,'north');

% Main game loop
while stage ~= 0 && timeLeft > 0
    switch stage
        % break out of loop/end game stage
        case 0
        
        % Intro Text
        case 1
            fprintf('A little over a week ago, patient zero escaped a military laboratory unleashing the zombie virus into your city.\n')
            fprintf('Since then, you have been hunkered down in your house waiting for the military to come to your salvation.\n')
            fprintf('Your radio comes to life and a deep voice says,\n')
            pause(.1)
            fprintf(2,'    "This is the United States Military. The city has been deemed a national \n')
            pause(.1)
            fprintf(2, '    threat and will be destroyed by a nuclear blast at nightfall. All survivors must leave the city before then."\n')
            waitgame(3)
            fprintf('\nyou must escape\n\npress any key to continue')
            getMouseInput(zomboid);
            stage = 2;
        % Choice of weapon 
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
       
        % Choice Which door to leave through
        % Ending #1: Be Sure To Listen
        case 3
            clc
            zombiePresent = randi(2);
            fprintf('You haven’t seen the outside of your house since the outbreak started, and the wood planks you put on the\n')
            fprintf('windows keep you from peaking outside. For all you know there could be a horde of zombies waiting.\n')
            fprintf('Should you leave through the front door or the back door?\n\n')
            fprintf(' [\ba.)   Listen through left door\n')
            fprintf(' b.)   Listen through right door\n')
            fprintf(' c.)   Choose left door\n')
            fprintf(' d.)   Choose right door]\b\n\n')
            while isequal(howLeave,'default')
                howLeave = getKeyboardInput(zomboid);
                if isequal(howLeave,'a')
                    if zombiePresent == 1
                        waitgame(randi(5))
                        fprintf('You hear what sounds like slight shuffling and')
                        waitgame(1)
                        fprintf('grunting\n')
                    else
                        waitgame(randi(5))
                        fprintf('You hear nothing\n')
                    end
                    howLeave = 'default';
                elseif isequal(howLeave,'b')
                    if zombiePresent == 2
                        waitgame(randi(5))
                        fprintf('You hear what sounds like slight shuffling and')
                        waitgame(1)
                        fprintf('grunting\n')
                    else
                        waitgame(randi(5))
                        fprintf('You hear nothing\n')
                    end
                    howLeave = 'default';
                elseif isequal(howLeave,'c')
                    if zombiePresent == 1
                        fprintf('You open the door to walk straight into a zombie. It bites your neck and your scream echoes for miles.\n')
                        fprintf('Your journey ends as soon as it starts.\n')
                        pause(.5)
                        fprintf(2,'\n\nYou Died ')
                        getMouseInput(zomboid);
                        stage = 0;
                        %win = false;
                        saveFile{1}(1) = 1;
                    else
                        stage = 4;
                    end
                elseif isequal(howLeave,'d')
                    if zombiePresent == 2
                        fprintf('You open the door to walk straight into a zombie. It bites your neck and your scream echoes for miles.\n')
                        fprintf('Your journey ends as soon as it starts.\n')
                        pause(.5)
                        fprintf(2,'\n\nYou Died ')
                        getMouseInput(zomboid);
                        stage = 0;
                        %win = false;
                        saveFile{1}(1) = 1;
                    else
                        stage = 4;
                    end
                else
                    howLeave = 'default';
                end
            end
        
        % Choice Kill Zombie?
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
                    fprintf('You carefully aim your handgun and shoot. You nail the zombie in the head. Easy kill. Then you hear the\n')
                    fprintf('noises from all around you. You look to see that you are surrounded by a horde. The gunshot drew at\n')
                    fprintf('least 20 other zombies over to you. You are torn limb from limb.\n\n')
                    pause(.5)
                    fprintf(2,'You Died ')
                    getMouseInput(zomboid);
                    stage = 0;
                    saveFile{1}(2) = 1;
                else
                    fprintf('You sneak close to the zombie until you are an arm''s length away and swiftly cut through its head with\n')
                    fprintf('your machete. You look down at the body to see that it was carrying something.\n\n')
                    fprintf(2,'First Aid Kit Acquired ')
                    getMouseInput(zomboid);
                    haveFirstAidKit = true;
                    stage = 5;
                end
                
            elseif isequal(attackDoorZombie,'b')
                stage = 5;
            else 
                attackDoorZombie = 'default';
            end
            
        end
        
        
        % How to escape
        % Ending #3: Hiker
        case 5
        clc;
        fprintf('As you walk away from your house you must quickly decide how you will escape. You could attempt to\n')
        fprintf('run on foot, take your car, or steal a boat docked in the nearby river.\n\n')
        fprintf(' [\ba.)   Walk\n')
        fprintf(' b.)   Take a car\n')
        fprintf(' c.)   Take a boat]\b\n\n')
        while isequal(transportation,'default')
           transportation = getKeyboardInput(zomboid);
           if isequal(transportation,'a')
               fprintf('You walk down the street at a swift pace, but the sun begins to set faster than you expected. You move\n')
               fprintf('faster but you quickly realize that you won’t make it out of the city before nightfall. As the sun sets you\n')
               fprintf('see the bomb fall, and the bright light that follows its descent.\n\n')
               pause(timeLeft)
               fprintf(2,'You Died ')
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
        
        % What to do when surrounded in car
        % Ending #4: Patience Isn't Key
        case 6
            clc;
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
                    pause(timeLeft-.5)
                    fprintf('The bomb hits you and you perish.\n\n')
                    fprintf(2,'You Died ')
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
                    getMouseInput(zomboid);
                    weapon = 'none';
                    stage = 8;
                else
                    howLeaveCar = 'default';
                end
            end
            
        % Help your rescuer?
        % Ending #5: Zombies aren't Bears
        %   Because you don't have to run faster then the bear, just your
        %   friend.  But this is evidently not the case for zombies.
        case 7
            clc;
            fprintf('You honk the car horn hoping that someone will help. You sit there waiting. All of a sudden you here\n')
            fprintf('rifle shots, and the zombies outside your car window begin dropping. One by one until they are all dead.\n')
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
                       fprintf('himself up, he introduces himself as Tyler, and tells you he got cut bad from falling on broken glass. He\n')
                       fprintf('offers to join you on your escape from the city, and you accept.\n\n')
                       fprintf(2,'Companion Acquired ')
                       getMouseInput(zomboid);
                       companion1 = true;
                       stage = 8;
                   elseif isequal(saveCompanion1,'b')
                       fprintf('You decide that you should save the first aid kit for yourself. You never know when you might need it.\n')
                       fprintf('You tell the man that you can’t help him. “that’s too bad” he says. He pulls his rifle up and shoots you.\n\n')
                       fprintf(2,'You Died ')
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
        
        % Which direction to escape in
        case 8
            clc;
            if companion1 == true
                fprintf('You and Tyler pull yourselves together and must quickly decide which way to take. You could go down\n')
                fprintf('the street, but there may be more hordes of zombies. Or you could go through the alleys, but if you get\n')
                fprintf('cornered there is no escape.\n\n')
            else
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
                
                    
        % What to do about the zombies in the alley
        % Ending #6: Knock Knock
        case 9
            clc;
            if companion1 == true
                fprintf('You decide it is best to take the alley, believing the street will only be more dangerous. You and Tyler\n')
                fprintf('move quickly but carefully. You pass by a dumpster and an arm grabs your leg. You scream and pull free.\n')
                fprintf('A zombie crawls out from under the dumpster which Tyler quickly kills, but the noise attracts more\n')
                fprintf('zombies. You both run to the end of the alley, but it leads to a dead end besides a door that leads to the\n')
                fprintf('nearby shop. Zombies are fast approaching.\n\n')
            else
                fprintf('You decide it is best to take the alley, believing the street will only be more dangerous. You move quickly\n')
                fprintf('but carefully. You pass by a dumpster and an arm grabs your leg. You scream and pull free. A zombie\n')
                fprintf('crawls out from under the dumpster and the noise attracts even more. You run to the end of the alley,\n')
                fprintf('but it leads to a dead end besides a door that leads to the nearby shop. Zombies are fast approaching.\n\n')
            end
            fprintf('The alley dead ends at a door, you turn around and see zombies approaching\n')
            fprintf(' [\ba.)   Try the door\n')
            fprintf(' b.)   Fight the zombies]\b\n\n')
            while isequal(alleyZombies,'default')
                alleyZombies = getKeyboardInput(zomboid);
                if isequal(alleyZombies,'a') && triedDoor == true
                    fprintf('You keep pulling on the door while banging over and over again. Last second the door swings open and\n')
                    fprintf('you leap inside.  You look up to see that a woman is your savior. She has a gun pointed in your direction\n')
                    fprintf('in case you try anything, but you quickly reassure her that you mean no harm. She introduces herself as\n')
                    fprintf('<strong>Alex</strong> and tells you that zombies are blocking all entrances and she has been stuck here for days.\n')
                    fprintf('There is nothing to do besides wait.\n\n')
                    fprintf(2,'Companion two Acquired')
                    getMouseInput(zomboid);
                    companion2 = true;
                    stage = 10;
                elseif isequal(alleyZombies,'b')
                    fprintf('You begin to fight the zombies, but they just keep coming. Your backs are pushed to the wall, and you\n')
                    fprintf('cannot keep up with the horde of zombies.\n\n')
                    fprintf(2,'You Died ')
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
        
        % Speak with the person
        case 10
            clc;
            fprintf('Do you talk to Alex or remain silent?\n')
            fprintf(' [\ba.)   Speak\n')
            fprintf(' b.)   Remain Silent]\b\n\n')
            while isequal(speakToComp,'default')
                speakToComp = getKeyboardInput(zomboid);
                if isequal(speakToComp,'a')
                    fprintf('Alex tells you that soon after the outbreak her and her husband took shelter in the store hoping for\n')
                    fprintf('rescue. A few days later her close friend left to get supplies and never returned. Not long after that zombies\n')
                    fprintf('crowded the street by the front door leaving her trapped. She says she must leave the city and return to\n')
                    fprintf('her family outside of town.\n\n')
                    getMouseInput(zomboid);
                elseif isequal(speakToComp,'b')
                else
                    speakToComp = 'default';
                end
            end
            stage = 11;
        
        % Check if you survive based on your weapon
        % Ending #7: At least bring a knife
        %   Because 'Don't bring a knife to a gun fight', but you don't
        %   have any weapon in this senario
        case 11
            clc;
            if isequal(weapon,'none')
                fprintf('The zombies out front must have heard the commotion and have been banging on the front door and\n')
                fprintf('the windows ever since. The window is beginning to steadily crack. You begin looking for a way out and\n')
                fprintf('notice a lock on a third entrance behind the counter that leads to the other side of the store, but the key\n')
                fprintf('is nowhere to be found. As you look around, suddenly you hear the window shatter, and the zombies\n')
                fprintf('begin flooding in. They attack Alex and tear her apart. You scramble around looking for a way out but\n')
                fprintf('it is too late. The zombies tear into you.\n\n')
                fprintf(2,'You Died ')
                getMouseInput(zomboid);
                stage = 0;
                saveFile(7) = 1;
            else
                stage = 12;
            end
        
        % Choice to save a companion
        % Ending #8: %The Hard Choice
        case 12
            clc;
            fprintf('The zombies out front must have heard the commotion and have been banging on the front door and\n')
            fprintf('the windows ever since. The window is beginning to steadily crack. You begin looking for a way out and\n')
            fprintf('notice a lock on a third entrance behind the counter that leads to the other side of the store, but the key\n')
            fprintf('is nowhere to be found. As you look around, suddenly you hear the window shatter, and the zombies\n')
            fprintf('begin flooding in. You see the undead going for Tyler and NAME at the same time. You can only save one\n\n')
            fprintf(' [\ba.)   Save Tyler\n')
            fprintf(' b.)   Save Alex]\b\n')
            
            while isequal(companionChoice,'default')
                companionChoice = getKeyboardInput(zomboid);
                if isequal(companionChoice,'a')
                    fprintf('You decide that you must save Tyler considering he has done the same for you. You take your machete\n')
                    fprintf('and kill the zombies behind him. You hear NAME scream but there is nothing you can do. You and Tyler\n')
                    fprintf('rush to the back of the store where the locked entrance is. You break the lock with your machete and\n')
                    fprintf('escape the store. You block the entrance behind you by sliding a pipe lying on the ground through the\n')
                    fprintf('handles. You look around and realize nightfall will come before the end of the hour. Not enough time to\n')
                    fprintf('make it out on foot. You then realize there is a bicycle lying in the street. You begin to walk for it until\n')
                    fprintf('Tyler stops you. He says he is taking it and you can’t stop him. You continue to go for the bike, but Tyler\n')
                    fprintf('says he is not afraid to kill you for it. He then rushes toward you to attack.\n\n')
                    fprintf('Time seems to slow as you Tyler approaches. You realize that you will have to quickly recognize the moves\n')
                    fprintf('he is about to make and respond appropriately.\n')
                    fprintf('Luckily you have been preparing for this moment all your life.  You have a bunch of martial art moves all numbered\n')
                    fprintf('and are prepared to use them as soon as you Tyler makes a move\n\n')
                    fprintf('Type the sequence of numbers you see to win the fight, press any key when you are ready')
                    getMouseInput(zomboid);
                    clc;
                    martialArts = randi(9,1,5)
                    pause(3);
                        messUp = false;
                        for i = 1:5
                            checkMartial = martialArts(i);
                            checkMartial = num2str(checkMartial);
                            checkMartial = unicode2native(checkMartial);
                            fightMove(i) = getKeyboardInput(zomboid);
                            if fightMove(i) ~= checkMartial
                                messUp = true;
                                break
                            end
                        end
                    if messUp == true
                        saveFile{1}(9) = 1;
                        fprintf('You mess use the wrong move and lose the battle\n\n')
                        fprintf(2,'You Died ')
                        getMouseInput(zomboid);
                    else
                        saveFile{1}(10) = 1;
                        fprintf('You preform better than you could have hoped, you quickly hop on the bike and pedal to safety')
                        getMouseInput(zomboid);
                    end
                    
                    stage = 0;
                elseif isequal(companionChoice,'b')
                    fprintf('You leap towards Alex and kill approaching zombies with your machete. You quickly glance towards\n')
                    fprintf('Tyler and see him be eaten while he looks you dead in the eye. You and NAME rush to the back of the\n')
                    fprintf('store where the locked entrance is. You begin hitting the lock with your machete. It seems that you\n')
                    fprintf('won''t get through it in time until it suddenly breaks, allowing you to escape to the backside of the store.\n')
                    fprintf('You block the entrance behind you by sliding your machete through the handles. You tell Alex that you\n')
                    fprintf('both need to get moving when she points out a motorcycle on the street. She then pulls out a pair of\n')
                    fprintf('keys and says she found them behind the counter earlier that day. You both get on and drive away.\n')
                    getMouseInput(zomboid);
                    saveFile{1}(8) = 1;
                    stage = 0;
                else 
                    companionChoice = 'default';
                end
            end
        
        % Fight with companion 1, if you win: win, if you lose: die 
        % Ending #9: Not Fit
        % Ending #10: Survival of the Fittest
%         case 13
%             doYouWinFight = randi(2);
%             if doYouWinFight == 1
%                 fprintf('You won the fight and successfully escaped\n')
%                 saveFile{1}(10) = 1;
%                 stage = 0;
%             else 
%                 fprintf('Companion2 won the fight and you died')
%                 stage = 0;
%                 saveFile{1}(9) = 1;
%             end
        
        % Enter Secret Code
        case 14
            clc;
            fprintf('You see a strange pannel')
            stage = 17;
        
        % Choice how to deal with bandit blockade
        % Ending #11: Best Friends
        % Ending #12: Don't Fight Alone
        %   Hint to need a companion
        case 15
            clc;
            fprintf('You continue along the street.  Soon encounter a bandit blockade, what do you do?\n\n')
            fprintf(' a.)   sneak past\n')
            fprintf(' b.)   fight\n\n')
            while isequal(banditBlockade,'default')
               banditBlockade = getKeyboardInput(zomboid);
               if isequal(banditBlockade,'b') && companion1 == true
                   fprintf('You and your companion escape and live happily ever after')
                   saveFile{1}(11) = 1;
                   stage = 0;
               elseif isequal(banditBlockade,'b')
                    fprintf('The bandits kill you')
                    stage = 0;
                    saveFile{1}(12) = 1;
               elseif isequal(banditBlockade,'a')
                   fprintf('you sneak around the bandits\n')
                   stage = 16;
               end
            end
        
        % How do you want to sneak around the bandits?
        % Ending #13: Not That Dangerous
        %   Because even a cornered rat can be dangerous, but it turns out
        %   that you weren't that dangerous.
        case 16
            clc;
            fprintf('How do you get around the bandits?\n\n')
            fprintf(' a.)   Go into buildings\n')
            fprintf(' b.)   Go into the sewers\n\n')
            while isequal(banditSneak,'default')
                banditSneak = getKeyboardInput(zomboid);
                if isequal(banditSneak,'a')
                    fprintf('Bandits hear you in the building and you are cornered and killed\n')
                    stage = 0;
                    saveFile{1}(13) = 1;
                elseif isequal(banditSneak,'b')
                    fprintf('You enter the sewers')
                    stage = 14;
                else 
                    banditSneak = 'default';
                end
            end
        
        % Do you save dog
        % Ending #14: Mans Best Friend
        % Ending #15: Misothery
        %   Because Misothery means contempt for animals
        % Ending #16: Bring Some Bandaids Maybe?
        case 17
            clc;
            fprintf('The sewers are a confusing place, especially in a zombie apocolypse\n')
            fprintf('Just as you are about to lose help you hear a dog.\n\n')
            if haveFirstAidKit == true
                fprintf(' a.)   Save dog\n')
                fprintf(' b.)   Let dog die\n\n')
                while isequal(dogSave,'default')
                    dogSave = getKeyboardInput(zomboid);
                    if isequal(dogSave,'a')
                        fprintf('You save the dog with your first aid kit.  The dog leads you out of the sewers, you both escape\n')
                        saveFile{1}(14) = 1;
                        stage = 0;
                    elseif isequal(dogSave,'b')
                        fprintf('You leave the dog where it is, not wanting unecessary burdens.  You don''t make it out in time\n')
                        saveFile{1}(15) = 1;
                    else
                        dogSave = 'default';
                    end
                end
            else
                fprintf('You sit with the dog waiting for the end')
                stage = 0;
                saveFile{1}(16) = 1;
            end
            pause(5)
        
        % Which river branch do you choose to go down
        % Ending #17: Inevitable Waterfall
        case 18
            clc
            fprintf('There is a branch in the river, which branch will you take?\n\n')
            fprintf(' a.)   Branch 1\n')
            fprintf(' b.)   Branch 2\n\n')
            while isequal(boatBranch,'default')
                boatBranch = getKeyboardInput(zomboid);
                if isequal(boatBranch,'a')
                    fprintf('The branch has a waterfall?')
                    stage = 0;
                    saveFile{1}(17) = 1;
                elseif isequal(boatBranch,'b')
                    fprintf('You enter the second branch')
                    stage = 19;
                else
                    boatBranch = 'default';
                end
            end
        % What do you do to survive rough waters
        % Ending #18: There weren't even Sharks
        case 19 
            clc
            fprintf('The water starts to roughen, what do you do?\n\n')
            fprintf(' a.)   Swim for the shore\n')
            fprintf(' b.)   Brace for impact\n\n')
            while isequal(roughWater,'default')
                roughWater = getKeyboardInput(zomboid);
                if isequal(roughWater,'a')
                    fprintf('The water is too rough and you die')
                    stage = 0;
                    saveFile{1}(18) = 1;
                elseif isequal(roughWater,'b')
                    fprintf('You survive the rough water')
                    stage = 20;
                else
                    roughWater = 'default';
                end
            end
        
        % What do you do with the damaged raft
        % Ending #19: SOS
        case 20
            clc;
            fprintf('You boat is damaged and is slowly sinking.  What do you do?\n')
            fprintf(' a.)   Use debri to paddle\n')
            fprintf(' b.)   Call for help\n')
            fprintf(' c.)   Swim to shore\n\n')
            while isequal(brokenBoat,'default')
                brokenBoat = getKeyboardInput(zomboid);
                if isequal(brokenBoat,'a')
                    fprintf('You don''t make it to shore in time and drown\n')
                    stage = 0; 
                    saveFile{1}(19) = 1;
                elseif isequal(brokenBoat,'b')
                    fprintf('you call for help\n')
                    weapon = 'none';
                    stage = 21;                    
                elseif isequal(brokenBoat,'c')
                    fprintf('The water is less rough and you make it to shore\n')
                    stage = 23;
                else
                    brokenBoat = 'default';
                end
            end
        
        % How do you fight the zombie
        % Ending #20: I used to be a human, then I took a bite too the knee
        %   I took an arrow to the knee
        % Ending #21: Who left that there?
        %   You trip on a banana that a bandit threw at your feet
        case 21
            clc;
            fprintf('Bandits answer your call and decide to save you.\nThey do make you fight against a zombie though\n')
            fprintf('How do you fight the zombie?\n')
            fprintf(' a.)   Punch it\n')
            fprintf(' b.)   Try and escape\n')
            fprintf(' c.)   Grab a bandit and push them infront of the zombie\n\n')
            while isequal(banditZombieFight,'default')
                banditZombieFight = getKeyboardInput(zomboid);
                if isequal(banditZombieFight,'a')
                    fprintf('You punch the zombie, it bites your arm.\n')
                    stage = 0;
                    saveFile{1}(20) = 1;
                elseif isequal(banditZombieFight,'b')
                    fprintf('You try and escape but the bandits pin you down and let the zombie kill you.\n')
                    stage = 0;
                    saveFile{1}(21) = 1;
                elseif isequal(banditZombieFight,'c')
                    fprintf('You pull a bandit into the ring, and the zombie kills them\n')
                    stage = 22;
                else
                    banditZombieFight = 'default';
                end
            end
        
        % Do you join the bandits
        % Ending #22: Straight up G
        case 22
            clc;
            fprintf('The bandits are so inpressed they offer you a spot in their gang\n\n')
            fprintf(' a.)   Accept Bandits offer\n')
            fprintf(' b.)   Decline Bandits offer\n\n')
            while isequal(banditOffer,'default')
                banditOffer = getKeyboardInput(zomboid);
                if isequal(banditOffer,'a')
                    fprintf('You join the bandits and terrorize the world for decades to come')
                    saveFile{1}(22) = 1;
                    stage = 0;
                elseif isequal(banditOffer,'b')
                    fprintf('The bandits are disapointed, but since they are impressed with your skill they let you go\n')
                    stage = 23;
                else
                    banditOffer = 'default';
                end
            end
        
        % Do you help the community
        case 23
            clc;
            fprintf('You get to the shore and find a large group of people trying to escape.\n\n')
            fprintf(' a.)   Help them\n')
            fprintf(' b.)   Carry on your way\n\n')
            while isequal(comunityChoice,'default')
                comunityChoice = getKeyboardInput(zomboid);
                if isequal(comunityChoice,'a')
                    fprintf('You decide to help the people\n')
                    stage = 24;
                elseif isequal(comunityChoice,'b')
                    fprintf('You leave without them\n')
                    stage = 25;
                else
                    comunityChoice = 'default';
                end
            end
        
        % How do you deal with the zombie horde
        % Ending #23: Charge!!!
        % Ending #24: Hero to the People
        case 24
            clc;
            fprintf('You decide to help the community, escape the zombie horde.  How?\n\n')
            fprintf(' a.)   Fight the zombies\n')
            fprintf(' b.)   Distract the hoard\n\n')
            while isequal(communityZombieHoard,'default')
                communityZombieHoard = getKeyboardInput(zomboid);
                if isequal(communityZombieHoard,'a')
                    fprintf('You the people to charge the zombies.\n You all die\n')
                    stage = 0;
                    saveFile{1}(23) = 1;
                elseif isequal(communityZombieHoard,'b')
                    fprintf('You distract all of the zombie by making a loud noise.\n')
                    fprintf('While you didn''t survive, you did save dozens of people.\n')
                    win = 'Hero to the people';
                    stage = 0;
                    saveFile{1}(24) = 1;
                else
                    communityZombieHoard = 'default';
                end
            end
            
        % Last path  
        % ending #24: Cold Blooded
        % ending #25: Well, what difference does it make
        %   Because you are rude and left the group of people to fend for
        %   themselves, so you are so immoral you are practically already
        %   not human, what difference does becoming a zombie make.
        % ending #26: No Escape
        case 25
            clc;
            fprintf('Ignored the peope in need and continued on your way\n')
            fprintf('Right before you can leave columbus there is a group of zombies in the way\n\n')
            fprintf(' a.)   Fight the zombies\n')
            fprintf(' b.)   Find another way out\n\n')
            while isequal(finalZombies,'default')
                finalZombies = getKeyboardInput(zomboid);
                if isequal(finalZombies,'a') && ~isequal(weapon,'none')
                    fprintf('You kill the zombies and escape\n')
                    win = 'Cold Blooded';
                    stage = 0;
                    saveFile{1}(25) = 1;
                elseif isequal(finalZombies,'a')
                    fprintf('You fail to kill the zombies\n')
                    stage = 0;
                    saveFile{1}(26) = 1;
                elseif isequal(finalZombies,'b')
                    fprintf('You don''t make it out in time\n')
                    stage = 0;
                    saveFile{1}(27) = 1;
                else
                    finalZombies = 'default';
                end
            end        
    end       
end
clc;

if timeLeft <= 0
    saveFile{1}(28) = 1;
end
    
for i = 1:28
    if saveFile{1}(i) == 1
        if sum(i == [8,10,11,14,22,25]) == 1
            fprintf('%s\n',endings{i,1});
        else
            fprintf('%s\n',endings{i,1});
        end
    else
        fprintf('%s\n',endings{29,1})
    end
end
stop(gameClock);
delete(gameClock);
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