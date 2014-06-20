clc;clear;
%Gets the number of rows and columns for the random matrix
MatrixDimensions; 

%Set the number of subplot columns and rows 
pObj = PlotDimensions;
pObj.plotRows = 2;
pObj.plotColumns = 2;     

%Create a client connection to the server socket
tcpIpClient = tcpip('129.10.53.156',55000,'NetworkRole','Client');

%Calculate the size of the matrix that that is going to be read
MatrixSize = @(m,n) (m*n);
sizeToRead = MatrixSize(numberOfRows,numberOfColumns);

%Calculate the number of bytes that that are going to be read
MatrixBytes = @(m,n) (MatrixSize(m,n)*8);
bytesToRead = MatrixBytes(numberOfRows,numberOfColumns);

%Set the InputBufferSize property so there is enough room to hold the data
%sent by the server
set(tcpIpClient,'InputBufferSize',bytesToRead);

%Define the waiting time for any read of write operation to complete
set(tcpIpClient,'Timeout',60);

%Open a TCPIP connection to the server
fopen(tcpIpClient);

%Initialize count
count=1;

%Create a figure to store the data in
figure;

%Initialize the while loop so it repeats until it the zeros matrix is
%received
quitLogical = false;
while ~quitLogical
    %Read the data that is being written out on the server
    rawData =fread(tcpIpClient,sizeToRead,'double');
    intSignal =fread(tcpIpClient,1,'int8');
    
    %
    enumSignal = commTags(intSignal);
    charSignal = char(enumSignal);

    switch charSignal
        case 'repeat'
            %Print the matrix number has been received
            fprintf('Matrix %i has been read\n',count);
            
            %Reshape the matrix so its dimensions are equal to those being
            %written to the server
            reshapedData = reshape(rawData,numberOfRows,numberOfColumns);
            
            %Plot the matrices at images
            subplot(pObj.plotRows,pObj.plotColumns,count);
            imagesc(reshapedData);
            
            %Add a title to each subplot
            strCount = num2str(count);
            strMatrix = 'Matrix ';
            strTitle = [strMatrix strCount];
            title(strTitle);
            
        case 'quit'
            quitLogical = true;
        otherwise
            fprintf('The client cannot recognize the integer signal being read\n');
    end
    
    %Increment counter
    count = count + 1;
end
%change the color map to gray and add a colorbar to the righthand side
colormap gray
B=colorbar; 
set(B, 'Position', [0.92 .10 .03 .8150]) 
%Close the server
fclose(tcpIpClient);