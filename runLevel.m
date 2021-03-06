function runLevel(gameObject, saveFile)
% Splits the inputed .txt file into layer 1 and 2.  Then draw the level to
% the inputed gameObject
    fullLevel = load(saveFile);
    fullDim = size(fullLevel);
    numOfRows = fullDim(1) ./ 2;
    for i = 1:numOfRows
       layer1(i,:) = fullLevel(i,:);
       layer2(i,:) = fullLevel(i+numOfRows,:);
    end
    
    drawScene(gameObject,layer1,layer2)
end

