zomboid = simpleGameEngine('retro_pack.png',16,16,5);
martialArts = randi(9,1,5)
for i = 1:5
    checkMartial = martialArts(i);
    checkMartial = num2str(checkMartial);
    checkMartial = unicode2native(checkMartial);
    fightMove(i) = getKeyboardInput(zomboid);
    if (fightMove(i)) ~= checkMartial;
        break
    end
end