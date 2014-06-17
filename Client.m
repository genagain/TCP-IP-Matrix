clc;clear;

MatrixDimensionsAndPlotDimensions; %Gets the number of rows and columns for the random matrix

%Create a client connection to the server socket
tcpIpClient = tcpip('129.10.53.156',55000,'NetworkRole','Client');

%Calculate the size of the matrix that that is going to be read
MatrixSize = @(m,n) (m*n);
sizeToRead = MatrixSize(numberOfRows,numberOfColumns);

%Calculate the number of bytes that that are going to be read
MatrixBytes = @(m,n) (MatrixSize(m,n)*8);
bytesToRead = MatrixBytes(numberOfRows,numberOfColumns);

%Generate a zeros matrix to terminate the connection
rawQuit = zeros(sizeToRead,1);

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
    
    
    enumSignal = commTags(intSignal);
    charSignal = char(enumSignal);
    
    switch charSignal
        case 'repeat'
            %Print the matrix number has been received
            fprintf('Matrix %i has been received\n',count);
            
            %Reshape the matrix so its dimensions are equal to those being
            %written to the server
            reshapedData = reshape(rawData,numberOfRows,numberOfColumns);
            
            %Plot the matrices at images
            subplot(plotRows,plotColumns,count);
            imagesc(reshapedData);
        case 'quit'
            quitLogical = true;
        otherwise
            fprintf('The client cannot recognize the integer signal\n');
    end
    
    %Increment counter
    count = count + 1;
end

%Close the server
fclose(tcpIpClient);