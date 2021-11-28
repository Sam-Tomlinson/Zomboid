% '*text' = thought
% [109, 110, 103] = background information
% 'err' = anouncements
% 'key' = options


% Zomboid: Escape from Columbus 
clc; clear; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5);
numberIndex = load('numberIndex.txt');
numberStr = load('numberStr.txt');
timeLeft = 1000;
gameClock = timer('ExecutionMode','FixedRate');
set(gameClock,'TimerFcn','timeLeft = gameTimer2(timeLeft,numberIndex,numberStr,clock);')
%movegui(gcf,'northeast')
% stage = 1;




% Debug tools and defaults
stage = input('Debug: What is your stage:  ')
weapon = 'default';
howLeave = 'default';
walkAttack = 'default';
transportation = 'default';
win = 'died';
zombiePresent = 1;

% Main Game Loop
while stage ~= 0 && timeLeft > 0 
    switch stage
        
        % End Stage, breaks out of loop, not sure if it will ever have
        % another purpose “¯\_(ツ)_/¯“.
        case 0
          
        % Start of game, give the introduction texts through cprintfs. 
        case 1
            cprintf([109, 110, 103],'A little over three days ago, the apocolypse began. I was just sitting in my house when I \nsuddenly heard strange moaning noises outside')
            cprintf([109, 110, 103],' I immediately dashed to my window and saw there were \nZOMBIES everywhere!  I went to my pantry and grabbed all the food that I could and went ')
            cprintf([109, 110, 103],'straight to the \ncellar.  I also managed to snag my radio on the way there and have been listening to it ever since.\n')
            pause(1)
            cprintf('err','\n\nIn wake of the tragedy that has been occuring, the military will be bombing the epicenter \nof the zombie outbreak, Columbus Ohio, in approxamently 1 hour')
            cprintf('err',' If you are residing in Columbus \nleave as soon as possible!\n\n')
            pause(1)
            stage = 2;
            
            % First decision, what weapon, do you want.  Either way you
            % could escape.
        case 2
            runLevel(zomboid,'Bunker.txt');
            start(gameClock);
            cprintf('*text','I need to get out of here, and fast!  But I can only carry so much.  In addition to supplies\nI also need a weapon.')
            cprintf('*text',' What should I choose?\n\n')
            cprintf('key','   a.) Gun\n   b.) Machete')
            while isequal(weapon,'default')
                weapon = getKeyboardInput(zomboid);
                if weapon == 'a'
                    weapon = 'Gun';
                elseif weapon == 'b'
                    weapon = 'Machete';
                else 
                    weapon = 'default';
                end
            end
            stage = 3;
        
        % decision on how to leave.  If you care about time you can just
        % pick at random, but you might die.  If you chose to listen first
        % you it will take 3 - 5 seconds, but you can pick the correct door.
        case 3
            %clc;
            zombiePresent = randi(2)
            runLevel(zomboid,'Bunker.txt')
            cprintf('*text','Hmm')
            waitgame('*text',1.8)
            cprintf('*text','I think I will bring a %s with me\n\n',weapon);
            pause(1)
            cprintf('*text','Enough distraction I need to leave. There may be zombies outside of my house though.\n')
            cprintf('*text','Should I choose at random or listen closely?\n\n')
            pause(1)
            cprintf('key','   a.) Leave through Left Door\n')
            cprintf('key','   b.) Leave through Right Door\n')
            cprintf('key','   c.) Listen to Left Door\n')
            cprintf('key','   d.) Listen to Right Door\n\n')
            while isequal(howLeave,'default')
                howLeave = getKeyboardInput(zomboid);
                if isequal(howLeave,'a')
                   if zombiePresent == 1
                       runLevel(zomboid,'checkLeftDoor.txt')
                       pause(1)
                       runLevel(zomboid,'leftDoorZombie.txt')
                       cprintf('*text','Oh no there is a zombie here\n')
                       cprintf('*text','Ahhhhhhhhhhhh\n')
                       stage = 0;
                   else
                       runLevel(zomboid,'checkLeftDoor.txt')
                       pause(1)
                       runLevel(zomboid,'leftDoorSafe.txt')
                       cprintf('*text','phew, looks like I''m safe!\n')
                       stage = 4;
                   end
                elseif isequal(howLeave,'b')
                    if zombiePresent == 2
                       runLevel(zomboid,'checkRightDoor.txt')
                       pause(1)
                       runLevel(zomboid,'rightDoorZombie.txt')
                       cprintf('*text','Oh no there was is a zombie here\n')
                       cprintf('*text','Ahhhhhhhhhhhh\n')
                       stage = 0;
                    else
                       runLevel(zomboid,'checkRightDoor.txt')
                       pause(1)
                       runLevel(zomboid,'rightDoorSafe.txt')
                       cprintf('*text','phew, looks like I''m safe\n')
                       stage = 4;
                    end
                elseif isequal(howLeave,'c')
                    if zombiePresent == 1
                        runLevel(zomboid,'checkLeftDoor.txt')
                        waitgame('*text',randi([3,5]));
                        runLevel(zomboid,'Bunker.txt')
                        cprintf('*text','you hear faint shuffling noizes\n')
                        cprintf('*text','I should probably leave through the right door\n')
                        howLeave = 'default'; 
                    else
                        runLevel(zomboid,'checkLeftDoor.txt')
                        waitgame('*text',randi([3,5]))
                        cprintf('*text','Sounds like the left door is safe\n')
                        howLeave = 'default';
                    end
                elseif isequal(howLeave,'d')
                     if zombiePresent == 2
                        runLevel(zomboid,'checkRightDoor.txt')
                        waitgame('*text',randi([3,5]));
                        runLevel(zomboid,'Bunker.txt')
                        cprintf('*text','you hear faint shuffling noizes\n')
                        cprintf('*text','I should probably leave through the left door\n')
                        howLeave = 'default';
                     else
                        runLevel(zomboid,'checkRightDoor.txt')
                        waitgame('*text',randi([3,5]))
                        runLevel(zomboid,'Bunker.txt')
                        cprintf('*text','Sounds like the right door is safe\n')
                        howLeave = 'default';
                     end
                else
                    howLeave = 'default';
                end
            end
        
            % Make a decision on whether or not to attack the zombie that
            % was outside your other door.  If you decide to attack with
            % the gun you will attrack other zombies and die, the machete
            % is safe, as is just walking away.
        case 4
            clc
            %close all

            if zombiePresent == 1
                runLevel(zomboid,'outsideZombieLeft.txt')
            else
                runLevel(zomboid,'outsideZombieRight.txt')
            end
            cprintf([109, 110, 103],'uhghhhhh\n\n')
            waitgame('*text',1.5)
            cprintf('*text','Theres a zombie over by the other door! Good thing I left through this door. ')
            cprintf('*text','I wonder')
            waitgame('*text',1)
            cprintf('*text','Should I attack it?\n\n')
            pause(.5)
            cprintf('key','   a.) Attack\n   b.) Walk away slowly\n\n')
            while isequal(walkAttack,'default')
                walkAttack = getKeyboardInput(zomboid);
                pause(1)
                if isequal(walkAttack,'a')
                    if isequal(weapon,'Gun')
                        runLevel(zomboid,'outsidePreparingShot.txt')
                        pause(1)
                        runLevel(zomboid,'outsideZombieKilled.txt')
                        cprintf('*text','Nice, got him!')
                        waitgame('*text',2)
                        runLevel(zomboid,'outsideZombiesAttracted.txt')
                        cprintf('*text','Oh no, I attracted zombies with the gunshot.\n')
                        pause(1)
                        runLevel(zomboid,'outsideZombiesAttractedDead.txt')
                        stage = 0;
                    else
                        runLevel(zomboid,'outsideSwordAttack.txt')
                        pause(1)
                        runLevel(zomboid,'outsideZombieKilled.txt')
                        cprintf('*text','That was hard! Good thing I had a sword.  I''m worried the gun may have attracted more zombies\n')
                        stage = 5;
                        
                    end
                elseif isequal(walkAttack,'b')
                    runLevel(zomboid,'outsideWalk.txt')
                    cprintf('*text','Good, it looks like the zombie didn''t hear me sneak passed.\n')
                    stage = 5;
                else
                    walkAttack = 'default';
                end
            end

            
        case 5 
            runLevel(zomboid,'crossroads.txt')
            cprintf('*text','Now, how should I leave Columbus?\n\n')
            cprintf('key','   a.) I could take a boat down the Olentangy\n')
            cprintf('key','   b.) I could take one of the abandoned cars\n')
            cprintf('key','   c.) I could walk along the sidewalk quietly\n\n')
            while isequal(transportation,'default')
                transportation = getKeyboardInput(zomboid);
                cprintf('*text','I think I will choose to')
                waitgame('*text',3)
                if transportation == 'a'
                    cprintf('*text','to take the boat down the Olentangy.')
                elseif transportation == 'b'
                    cprintf('*text','to take one of the abandoned cars, they owner won''t need it anyway.')
                elseif transportation == 'c'
                    cprintf('*text','to walk.  Making loud noises may be a bad decision.\n')
                    runLevel(zomboid,'crossroadsWalk.txt')
                    pause(3)
                    while timeLeft > 5
                        timeLeft = gameTimer(timeLeft,timePassed,clock)
                        pause(.1)
                        runLevel(zomboid,'walking1.txt')
                        pause(3)
                        runLevel(zomboid,'walking2.txt')
                        pause(3)
                    end
                    cprintf('*text','Maybe walking wasn''t the best decision.')
                else
                    transportation = 'default'
                end
            end
            stage = 6;
        
        
        case 6
            
    end
end

stop(gameClock);
delete(gameClock);

clc
if timeLeft > 0 && isequal(win,'died')
    close all
    cprintf('*err','You died')
    imshow('YouDied.png')
elseif timeLeft < 0 
    close all
    cprintf('*err','You didn''t make it out in time')
    pause(3)
    imshow('YouDied.png')
else
    cprintf('*Green','YOU ESCAPED!!!')
end
