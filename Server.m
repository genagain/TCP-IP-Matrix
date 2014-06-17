clc;clear;
MatrixDimensionsAndPlotDimensions %Gets the number of rows and columns for the random matrix

%Calculate the size of the matrix that that is going to be read
MatrixSize = @(m,n) (m*n);
sizeToWrite = MatrixSize(numberOfRows,numberOfColumns);

%Calculate the number of bytes that that are going to be read
MatrixBytes = @(m,n) (MatrixSize(m,n)*8);
bytesToWrite = MatrixBytes(numberOfRows,numberOfColumns);

%Start a TCP/IP server socket in MATLAB by setting the IP address to '0.0.0.0'
tcpIpServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');

%Set to 'OutputBufferSize' large enough to hold the data
set(tcpIpServer,'OutputBufferSize',bytesToWrite);

%Open the server socket and wait for a connection
fopen(tcpIpServer);

%Create a matrix to send that terminates the connection on the client side
quitMatrix = zeros(numberOfRows,numberOfColumns);
quitSignal = 0;
repeatSignal = 1;

%Generate and write random matrices to the server socket every 3 seconds
for i = 1:numberOfIterations
    randomMatrix = rand(numberOfRows,numberOfColumns);
    fwrite(tcpIpServer,randomMatrix(:),'double');
    fwrite(tcpIpServer,repeatSignal,'int8');
    pause(3);
end

%Write the matrix to send that terminates the connection on the client side
fwrite(tcpIpServer,quitMatrix(:),'double');
fwrite(tcpIpServer,quitSignal,'int8');

%Close the server
fclose(tcpIpServer);