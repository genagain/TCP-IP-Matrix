classdef PlotDimensions
    %PlotDimensions is a class that has the properties needed to generate
    %the number of matrices in the server script and plot these matrices in
    %the client script.  It is important to note that when useing this
    %class, the numberOfMatrices cannot exceed the product of plotRows and
    %plotColumns because there need to be enough subplots for plot all of
    %the generated matrices.  
    %For example if the numberOfMatrices equaled 5 and the product of 
    %plotRows and plotColumns was 4,  the fifth matrix generated could not
    %be plotted on the subplot.
    %
    %PlotDimensions Properties:
    %   numberOfMatrices - This is the total number of matrices that are
    %   generated in the server script
    %   plotRows - This is the number of rows the subplot will create in 
    %   the client script.  
    %   plotColumns - This is the number of columns the subplot will create 
    %   in the client script.  
    properties
    %   numberOfMatrices - First property of class
    %   This is the total number of matrices that are generated in the 
    %   server script
        numberOfMatrices
    %   plotRows - Second property of class
    %   This is the number of rows the subplot will create in the client 
    %   script. 
        plotRows
    %   plotColumns - Third property of class
    %   This is the number of columns the subplot will create in the client 
    %   script. 
        plotColumns
    end
end