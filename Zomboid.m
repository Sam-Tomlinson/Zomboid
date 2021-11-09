% '*text' = thought
% [109, 110, 103] = background information
% 'err' = anouncements
% 'key' = 


%Zomboid: Escape from Columbus 
clc; clear; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5);
%stage = 3;
timeLeft = 20;
gameTimer(300,0,clock);
movegui(gcf,'northeast')

%Debug tools and defaults
stage = input('Debug: What is your stage:  ')
weapon = 'default';
howLeave = 'default';
walkAttack = 'default';
win = 'died';
zombiePresent = 1;

while stage ~= 0 && timeLeft > 0 
    switch stage
        case 0
          
        case 1
            %clc
            cprintf('*err','you %s',win)
            stage = 0;
        case 2
        case 3
            runLevel(zomboid,'Bunker.txt');
            gameTimer(timeLeft,0,clock)
            tstart = tic;
            cprintf([109, 110, 103],'A little over three days ago, the apocolypse began. I was just sitting in my house when I \nsuddenly heard strange moaning noises outside')
            cprintf([109, 110, 103],' I immediately dashed to my window and saw there were \nZOMBIES everywhere!  I went to my pantry and grabbed all the food that I could and went ')
            cprintf([109, 110, 103],'straight to the \ncellar.  I also managed to snag my radio on the way there and have been listening to it ever since.\n')
            cprintf('err','\n\nIn wake of the tragedy that has been occuring, the military will be bombing the epicenter \nof the zombie outbreak, Columbus Ohio, in approxamently 5 hours')
            cprintf('err','If you are residing in Columbus \nleave as soon as possible!\n\n')
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
                    clear weapon
                end
            end
            timePassed = floor(toc(tstart));
            timeLeft = gameTimer(timeLeft,timePassed,clock);
            stage = 4;
        case 4
            %clc;
            tstart = tic;
            zombiePresent = randi(2)
            runLevel(zomboid,'Bunker.txt')
            cprintf('*text','Hmm . ')
            pause(.3)
            cprintf('*text','. ')
            pause(.3)
            cprintf('*text','. ')
            pause(.8)
            cprintf('*text','I think I will bring a %s with me\n\n',weapon);
            pause(.8)
            cprintf([109, 110, 103],'Enough distraction I need to leave. There may be zombies outside of my house though.\n')
            cprintf([109, 110, 103],'Should I choose at random or listen closely?\n\n')
            pause(.8)
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
                       cprintf('*text','Ahhhhhhhhhhhh')
                       stage = 0;
                   else
                       runLevel(zomboid,'checkLeftDoor.txt')
                       pause(1)
                       runLevel(zomboid,'leftDoorSafe.txt')
                       cprintf('*text','phew, looks like I''m safe!\n')
                       stage = 5;
                   end
                elseif isequal(howLeave,'b')
                    if zombiePresent == 2
                       runLevel(zomboid,'checkRightDoor.txt')
                       pause(1)
                       runLevel(zomboid,'rightDoorZombie.txt')
                       cprintf('*text','Oh no there was is a zombie here\n')
                       cprintf('*text','Ahhhhhhhhhhhh')
                       stage = 0;
                    else
                       runLevel(zomboid,'checkRightDoor.txt')
                       pause(1)
                       runLevel(zomboid,'rightDoorSafe.txt')
                       cprintf('*text','phew, looks like I''m safe\n')
                       stage = 5;
                    end
                elseif isequal(howLeave,'c')
                    if zombiePresent == 1
                        runLevel(zomboid,'checkLeftDoor.txt')
                        waitgame('*text',3);
                        runLevel(zomboid,'Bunker.txt')
                        cprintf('*text','you hear faint shuffling noizes\n')
                        cprintf('*text','I should probably leave through the right door\n')
                        howLeave = 'default'; 
                    else
                        runLevel(zomboid,'checkLeftDoor.txt')
                        waitgame('*text',3)
                        cprintf('*text','Sounds like the left door is safe\n')
                        howLeave = 'default';
                    end
                elseif isequal(howLeave,'d')
                     if zombiePresent == 2
                        runLevel(zomboid,'checkRightDoor.txt')
                        waitgame('*text',3);
                        runLevel(zomboid,'Bunker.txt')
                        cprintf('*text','you hear faint shuffling noizes\n')
                        cprintf('*text','I should probably leave through the left door\n')
                        howLeave = 'default';
                     else
                        runLevel(zomboid,'checkRightDoor.txt')
                        waitgame('*text',3)
                        runLevel(zomboid,'Bunker.txt')
                        cprintf('*text','Sounds like the right door is safe\n')
                        howLeave = 'default';
                     end
                else
                    howLeave = 'default';
                end
            end
            timePassed = floor(toc(tstart));
            timeLeft = gameTimer(timeLeft,timePassed,clock);
            pause(1)
            
        case 5
            clc
            %close all
            tstart = tic;
            if zombiePresent == 1
                runLevel(zomboid,'outsideZombieLeft.txt')
            else
                runLevel(zomboid,'outsideZombieRight.txt')
            end
            cprintf([109, 110, 103],'uhghhhhh\n\n')
            waitgame('*text',1.5)
            cprintf('*text','Theres a zombie over by the other door! Good thing I left through this door.')
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
                        cprintf('*text','Oh no, I attracted zombies with the gunshot')
                        pause(1)
                        runLevel(zomboid,'outsideZombiesAttractedDead.txt')
                        stage = 0;
                    else
                        runLevel(zomboid,'outsideSwordAttack.txt')
                        pause(1)
                        runLevel(zomboid,'outsideZombieKilled.txt')
                        cprintf('*text','That was hard! Good thing I had a sword.  I''m worried the gun may have attracted more zombies')
                        stage = 6;
                        
                    end
                elseif isequal(walkAttack,'b')
                    runLevel(zomboid,'outsideWalk.txt')
                    stage = 6;
                else
                    walkAttack = 'default';
                end
            end
        timePassed = floor(toc(tstart));
        timeLeft = gameTimer(timeLeft,timePassed,clock);
        pause(1)
    end
end
if timeLeft > 0 && isequal(win,'died')
    cprintf('*err','YOU DIED')
elseif timeLeft < 0 
    cprintf('*err','YOU WERE NUKED')
    time
else
    cprintf('*Green','YOU Win')
end





