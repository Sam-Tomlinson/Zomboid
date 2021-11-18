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
companionChoice = 'default'

%Debug stuff
runLevel(zomboid,'blankScreen.txt')

% Main game loop
while stage ~= 0 && timeLeft > 0
    switch stage
        % break out of loop/end game stage
        case 0
        
        % Intro Text
        case 1
            fprintf('Intro Text\n')
            stage = 2;
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
                        win = false;
                    else
                        stage = 4;
                    end
                elseif isequal(howLeave,'d')
                    if zombiePresent == 2
                        fprintf('Oh no a zombie!')
                        stage = 0;
                        win = false;
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
        
        % Check if you have a gun: win 
        case 13
            doYouWinFight = randi(2);
            if doYouWinFight == 1
                fprintf('You wond the fight and successfully escaped\n')
                win = 'Survival of the Fittest';
                stage = 0;
            else 
                fprintf('Companion2 won the fight and you died')
                stage = 0;
            end
        
        % if you had no weapon/machete: fight
        case 14
        
        % Choice how to deal with bandit blockade
        case 15
        
        % How do you want to sneak around the bandits?
        case 16
        
        % Do you save dog
        case 17
        
        % Which river branch do you choose to go down
        case 18
        
        % What do you do to survive rough waters
        case 19 
        
        % What do you do with the damaged raft
        case 20
        
        % How do you fight the zombie
        case 21
        
        % Do you join the bandits
        case 22
        
        % Do you help the community
        case 23
        
        % How do you deal with the zombie horde
        case 24
    end       
end
clc;
fprintf('%s',win)