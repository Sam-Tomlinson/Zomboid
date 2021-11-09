%Zomboid: Escape from Columbus 
clc; clear; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5)
stage = 2;
timeLeft = 300
while stage ~= 0
    switch stage
        case 0
        case 1
            
        case 2
            %runLevel(zomboid,'Bunker.txt');
            tstart = tic;
            cprintf('*Text','A little over three days agop the apocolypse began. I was just sitting in my house when I \nsuddenly heard strange moaning noises outside')
            cprintf('*text',' I immediately dashed to my window and saw there were \nZOMBIES everywhere!  I went to my pantry and grabbed all the food that I could and went ')
            cprintf('*text','straight to the \ncellar.  I also managed to snag my radio on the way there and have been listening to it ever since.\n')
            cprintf('err','\n\nIn wake of the tragedy that has been occuring, the military will be bombing the epicenter \nof the zombie outbreak, Columbus Ohio, in approxamently 5 hours')
            cprintf('err','If you are residing in Columbus \nleave as soon as possible!')
            timePassed = toc(tstart);
            %timeLeft = gameTimer(timeLeft,timePassed,clock)
            pause(100000)
    end
end
tstart = tic;
pause(2)
tend = toc(tstart)




