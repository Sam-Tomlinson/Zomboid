%Zomboid: Escape from Columbus 
clc; clear; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5)
stage = 3;
timeLeft = 300
while stage ~= 0 && stage ~=1
    switch stage
        case 0
        case 1
            
        case 2
        case 3
            runLevel(zomboid,'Bunker.txt');
            gameTimer(timeLeft,0,clock)
            tstart = tic;
            cprintf('*Text','A little over three days ago, the apocolypse began. I was just sitting in my house when I \nsuddenly heard strange moaning noises outside')
            cprintf('*text',' I immediately dashed to my window and saw there were \nZOMBIES everywhere!  I went to my pantry and grabbed all the food that I could and went ')
            cprintf('*text','straight to the \ncellar.  I also managed to snag my radio on the way there and have been listening to it ever since.\n')
            cprintf('err','\n\nIn wake of the tragedy that has been occuring, the military will be bombing the epicenter \nof the zombie outbreak, Columbus Ohio, in approxamently 5 hours')
            cprintf('err','If you are residing in Columbus \nleave as soon as possible!\n\n')
            cprintf([109, 110, 103],'I need to get out of here, and fast!  But I can only carry so much.  In addition to supplies\nI also need a weapon.')
            cprintf([109, 110, 103],' What should I choose?\n\n')
            cprintf('key','   a.) Gun\n   b.) Machete')
            while ~exist('weapon')
                weapon = getKeyboardInput(zomboid);
                if weapon == 'a'
                    weapon = 1;
                elseif weapon == 'b'
                    weapon = 2;
                else 
                    clear weapon
                end
            end
            timePassed = floor(toc(tstart));
            timeLeft = gameTimer(timeLeft,timePassed,clock);
            stage = 4;
        case 4
            stage = 0;
           
    end
end





