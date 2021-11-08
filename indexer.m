function oneNumIndex = indexer(arrayDim, rowVal, columnVal, gameEngine);
    %Converts a [row, column] index into a onenum index.  
    %Syntax: oneNumIndex = indexer(size(array),rowVal,columnVal,gameEngine)
    %where array is the array you are indexing, and gameEngine is an
    %optional input.  If you have a 4th input, you will get a result useful 
    %with simpleGameEngine.
    if nargin == 4
        oneNumIndex = (rowVal-1)*arrayDim(1) + columnVal;
    else
        oneNumIndex = (columnVal-1)*arrayDim(2) + rowVal; 
end