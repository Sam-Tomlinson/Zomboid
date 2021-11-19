% Zomboid escape from Columbus
% Start stuff
clc; clear; close all;
zomboid = simpleGameEngine('retro_pack.png',16,16,5);
clock = simpleGameEngine('retro_pack.png',16,16,5);
numberIndex = load('numberIndex.txt');
numberStr = load('numberStr.txt');
timeLeft = 10;
gameClock = timer('ExecutionMode','FixedRate');
set(gameClock,'TimerFcn','timeLeft = gameTimer2(timeLeft,numberIndex,numberStr,clock);');

% Initilizing variables
stage = 1;
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
runLevel(zomboid,'blankScreen.txt')

% Main game loop
while stage ~= 0 && timeLeft > 0
    switch stage
        % break out of loop/end game stage
        case 0
        
        % Intro Text
        case 1
            cprintf('[109, 110, 103]','A little over a week ago, patient zero escaped a military laboratory unleashing the zombie virus into your city.\n')
            cprintf('[109, 110, 103]','Since then, you have been hunkered down in your house waiting for the military to come to your salvation.\n')
            cprintf('[109, 110, 103]','Your radio comes to life and a deep voice says,\n')
            cprintf('err','    "This is the United States Military. The city has been deemed a national threat and will be destroyed by \n     a nuclear blast at nightfall.')
            cprintf('err',' All survivors must leave the city before then.”\n')
            waitgame('*text',3)
            cprintf('*text','You must escape')
            stage = 2;
            pause(100)
        % Choice of weapon 
        case 2
            clc
            fprintf('Choose a weapon\n\n')
            fprintf(' a.)   Gun\n')
            fprintf(' b.)   Machete\n\n')
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
        case 3
            clc
            zombiePresent = randi(2);
            fprintf('What door should I leave through?\n\n')
            fprintf(' a.)   Listen through left door\n')
            fprintf(' b.)   Listen through right door\n')
            fprintf(' c.)   Choose left door\n')
            fprintf(' d.)   Choose right door\n\n')
            while isequal(howLeave,'default')
                howLeave = getKeyboardInput(zomboid);
                if isequal(howLeave,'a')
                    if zombiePresent == 1
                        fprintf('zombie outside door\n')
                    else
                        fprintf('door is safe\n')
                    end
                    howLeave = 'default';
                elseif isequal(howLeave,'b')
                    if zombiePresent == 2
                        fprintf('zombie outside door\n')
                    else
                        fprintf('door is safe\n')
                    end
                    howLeave = 'default';
                elseif isequal(howLeave,'c')
                    if zombiePresent == 1
                        fprintf('Oh no a zombie!')
                        stage = 0;
                    else
                        stage = 4;
                    end
                elseif isequal(howLeave,'d')
                    if zombiePresent == 2
                        fprintf('Oh no a zombie!')
                        stage = 0;
                    else
                        stage = 4;
                    end
                else
                    howLeave = 'default';
                end
            end
        
        % Choice Kill Zombie?
        case 4 
        clc;
        fprintf('You see there is a zombie outside the other door\n')
        fprintf('What do you do?\n\n')
        fprintf(' a.)   Attack it\n')
        fprintf(' b.)   Sneak past it\n\n')
        while isequal(attackDoorZombie,'default')
            attackDoorZombie = getKeyboardInput(zomboid);
            if isequal(attackDoorZombie,'a')
                if isequal(weapon,'Gun')
                    fprintf('In killing the zombie you attracted more zombies and died\n')
                    stage = 0;
                else
                    fprintf('You successfully killed the zombie')
                    haveFirstAidKit = true;
                    stage = 5;
                end
                
            elseif isequal(attackDoorZombie,'b')
                fprintf('You successfully snuck past the zombie')
                stage = 5;
            else 
                attackDoorZombie = 'default';
            end
            
        end
        
        
        % How to escape
        case 5
        clc;
        fprintf('Now you need to decide how to escape\n\n')
        fprintf(' a.)   Walk\n')
        fprintf(' b.)   Take a car\n')
        fprintf(' c.)   Take a boat\n')
        while isequal(transportation,'default')
           transportation = getKeyboardInput(zomboid);
           if isequal(transportation,'a')
               fprintf('You could not walk out of the city fast enough')
               %need to set this up to run down timer with a while timeLeft
               %> 0 loop
               stage = 0;
           elseif isequal(transportation,'b')
               fprintf('You look around at some cars, luckily you find one with keys left in the ignition\n')
               stage = 6;
           elseif isequal(transportation,'c')
               fprintf('You spot a boat in the olentangy, you hop in\n')
               stage = 18;
           else
               transportation = 'default';
           end
        end
        
        % What to do when surrounded in car
        case 6
            clc;
            fprintf('Your car was loud and attracted a zombie hoard, what do you do?\n\n')
            fprintf(' a.)   Wait it out\n')
            fprintf(' b.)   Honk Horn and hope someone hears\n')
            fprintf(' c.)   Attack the zombies and make a break for it\n\n')
            while isequal(howLeaveCar,'default')
                howLeaveCar = getKeyboardInput(zomboid);
                if isequal(howLeaveCar,'a')
                    fprintf('The zombies don''t leave and you sit in the car till the nuke')
                    % Need to add while loop to run down clock
                    stage = 0;
                elseif isequal(howLeaveCar,'b')
                    fprintf('Your horn attracts a stranger to come save you\n')
                    stage = 7;
                elseif isequal(howLeaveCar,'c')
                    fprintf('You successfully escape but you lose your weapon\n')
                    weapon = 'none';
                    stage = 8;
                else
                    howLeaveCar = 'default';
                end
            end
            
        % Help your rescuer
        case 7
            clc;
            fprintf('While helping you, the stranger injures himself\n')
            if haveFirstAidKit == true
                fprintf('You have a first aid kit, do you use it to save the stranger?\n\n')
                fprintf(' a.)   Yes\n')
                fprintf(' b.)   No\n\n')
                while isequal(saveCompanion1,'default')
                   saveCompanion1 = getKeyboardInput(zomboid);
                   if isequal(saveCompanion1,'a')
                       fprintf('You use your first aid kit to save the stranger\n')
                       companion1 = true;
                       stage = 8;
                   elseif isequal(saveCompanion1,'b')
                       fprintf('Slowed by his injury, you and the stranger both get overun by zombies\n')
                       stage = 0;
                   else
                       saveCompanion1 = 'default';
                   end
                end
            else
                fprintf('Slowed by his injury, you and the stranger both get overun by zombies\n')
                stage = 0;
            end
        
        % Which direction to escape in
        case 8
            clc;
            fprintf('You reach alley do you:\n\n')
            fprintf(' a.)   enter the alley\n')
            fprintf(' b.)   continue along the street\n\n')
            while isequal(alleyStreet,'default')
                alleyStreet = getKeyboardInput(zomboid);
                if isequal(alleyStreet,'a')
                    fprintf('You enter the alley\n')
                    stage = 9;
                elseif isequal(alleyStreet,'b')
                    fprintf('You continue along the street\n')
                    stage = 15;
                else
                    alleyStreet = 'default';
                end
            end
                
                    
        % What to do about the zombies in the alley
        case 9
            clc;
            fprintf('The alley dead ends at a door, you turn around and see zombies approaching\n')
            fprintf(' a.)   Try the door\n')
            fprintf(' b.)   Fight the zombies\n\n')
            while isequal(alleyZombies,'default')
                alleyZombies = getKeyboardInput(zomboid);
                if isequal(alleyZombies,'a') && triedDoor == true
                    fprintf('You hear some rustling behind the door and it swings open\n')
                    companion2 = true;
                    stage = 10;
                elseif isequal(alleyZombies,'b')
                    fprintf('You attempt to fight, but there are too many zombies and you die\n')
                    stage = 0;
                elseif isequal(alleyZombies,'a') 
                    fprintf('The door appears to be locked\n')
                    triedDoor = true;
                    alleyZombies = 'default';
                else
                    alleyZombies = 'default';
                end
            end
        
        % Speak with the person
        case 10
            clc;
            fprintf('A woman gestures you inside the building\n')
            fprintf('Do you speak to them?\n')
            %No choices devloped hear yey
            stage = 11;
        
        % Check if you survive based on your weapon
        case 11
            clc;
            if isequal(weapon,'none')
                fprintf('Zombies break through the door and you all die\n')
                stage = 0;
            else
                fprintf('The doors break open and a few zombies get through, you kill them with your weapion\n')
                stage = 12;
            end
        
        % Choice to save a companion
        case 12
            clc;
            fprintf('You run out of the building and there are zombie everywhere\n')
            fprintf('You and your companion are about to get split up do you:\n')
            fprintf(' a.)   Save companion1\n')
            fprintf(' b.)   Save companion2\n')
            
            while isequal(companionChoice,'default')
                companionChoice = getKeyboardInput(zomboid);
                if isequal(companionChoice,'a')
                    fprintf('You and companion1 exit the building, but for PLOT only one of you can escape\n')
                    stage = 13;
                elseif isequal(companionChoice,'b')
                    fprintf('You and companion2 successfully escape the horde and get out of columbus\n')
                    win = 'The Hard Choice';
                    stage = 0;
                else 
                    companionChoice = 'default';
                end
            end
        
        % Fight with companion 1, if you win: win, if you lose: die 
        case 13
            doYouWinFight = randi(2);
            if doYouWinFight == 1
                fprintf('You won the fight and successfully escaped\n')
                win = 'Survival of the Fittest';
                stage = 0;
            else 
                fprintf('Companion2 won the fight and you died')
                stage = 0;
            end
        
        % if you had no weapon/machete: fight
        case 14
            clc;
            fprintf('You see a strange pannel')
            stage = 17;
        
        % Choice how to deal with bandit blockade
        case 15
            clc;
            fprintf('You continue along the street.  Soon encounter a bandit blockade, what do you do?\n\n')
            fprintf(' a.)   sneak past\n')
            fprintf(' b.)   fight\n\n')
            while isequal(banditBlockade,'default')
               banditBlockade = getKeyboardInput(zomboid);
               if isequal(banditBlockade,'b') && companion1 == true
                   fprintf('You and your companion escape and live happily ever after')
                   win = 'Best Friends';
                   stage = 0;
               elseif isequal(banditBlockade,'b')
                    fprintf('The bandits kill you')
                    stage = 0;
               elseif isequal(banditBlockade,'a')
                   fprintf('you sneak around the bandits\n')
                   stage = 16;
               end
            end
        
        % How do you want to sneak around the bandits?
        case 16
            clc;
            fprintf('How do you get around the bandits?\n\n')
            fprintf(' a.)   Go into buildings\n')
            fprintf(' b.)   Go into the sewers\n\n')
            while isequal(banditSneak,'default')
                banditSneak = getKeyboardInput(zomboid);
                if isequal(banditSneak,'a')
                    fprintf('There is a zombie in the building and you die\n')
                    stage = 0;
                elseif isequal(banditSneak,'b')
                    fprintf('You enter the sewers')
                    stage = 14;
                else 
                    banditSneak = 'default';
                end
            end
        
        % Do you save dog
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
                        win = 'Mans best friend';
                        stage = 0;
                    elseif isequal(dogSave,'b')
                        fprintf('You leave the dog where it is, not wanting unecessary burdens.  You don''t make it out in time\n')
                        stage = 0;
                    else
                        dogSave = 'default';
                    end
                end
            else
                fprintf('You sit with the dog waiting for the end')
                stage = 0;
            end
            pause(5)
        
        % Which river branch do you choose to go down other branch may be
        % fine eventually
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
                elseif isequal(boatBranch,'b')
                    fprintf('You enter the second branch')
                    stage = 19;
                else
                    boatBranch = 'default';
                end
            end
        % What do you do to survive rough waters
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
                elseif isequal(roughWater,'b')
                    fprintf('You survive the rough water')
                    stage = 20;
                else
                    roughWater = 'default';
                end
            end
        
        % What do you do with the damaged raft
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
                elseif isequal(banditZombieFight,'b')
                    fprintf('You try and escape but the bandits pin you down and let the zombie kill you.\n')
                    stage = 0;
                elseif isequal(banditZombieFight,'c')
                    fprintf('You pull a bandit into the ring, and the zombie kills them\n')
                    stage = 22;
                else
                    banditZombieFight = 'default';
                end
            end
        
        % Do you join the bandits
        case 22
            clc;
            fprintf('The bandits are so inpressed they offer you a spot in their gang\n\n')
            fprintf(' a.)   Accept Bandits offer\n')
            fprintf(' b.)   Decline Bandits offer\n\n')
            while isequal(banditOffer,'default')
                banditOffer = getKeyboardInput(zomboid);
                if isequal(banditOffer,'a')
                    fprintf('You join the bandits and terrorize the world for decades to come')
                    win = 'Straight up g';
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
                elseif isequal(communityZombieHoard,'b')
                    fprintf('You distract all of the zombie by making a loud noise.\n')
                    fprintf('While you didn''t survive, you did save dozens of people.\n')
                    win = 'Hero to the people';
                    stage = 0;
                else
                    communityZombieHoard = 'default';
                end
            end
            
        % Last path   
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
                elseif isequal(finalZombies,'a')
                    fprintf('You fail to kill the zombies\n')
                    stage = 0;
                elseif isequal(finalZombies,'b')
                    fprintf('You don''t make it out in time\n')
                    stage = 0;
                else
                    finalZombies = 'default';
                end
            end        
    end       
end
clc;
fprintf('%s',win)