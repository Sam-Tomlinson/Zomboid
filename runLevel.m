function runLevel(gameObject, saveFile)

    fullLevel = load(saveFile);
    fullDim = size(fullLevel);
    numOfRows = fullDim(1) ./ 2;
    for i = 1:numOfRows
       layer1(i,:) = fullLevel(i,:);
       layer2(i,:) = fullLevel(i+numOfRows,:);
    end
    
    drawScene(gameObject,layer1,layer2)
end

