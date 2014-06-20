clc;clear;
%Gets the number of rows and columns for the random matrix
MatrixDimensions 

%Set the number of matrices to generate
pObj = PlotDimensions;
pObj.numberOfMatrices = 4;

%Starts another Matlab session and runs the client script
str ='!matlab -r "Client" &';
eval(str)

%Calculate the size of the matrix that that is going to be read
MatrixSize = @(m,n) (m*n);
sizeToWrite = MatrixSize(numberOfRows,numberOfColumns);

%Calculate the number of bytes that that are going to be read
MatrixBytes = @(m,n) (MatrixSize(m,n)*8);
bytesToWrite = MatrixBytes(numberOfRows,numberOfColumns);

%Start a TCP/IP server socket in MATLAB by setting the IP address to '0.0.0.0'
tcpIpServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
fprintf('A TCP/IP server socket has been started');

%Set to 'OutputBufferSize' large enough to hold the data
set(tcpIpServer,'OutputBufferSize',bytesToWrite);

%Open the server socket and wait for a connection
fopen(tcpIpServer);

%Create a matrix to send that terminates the connection on the client side
quitMatrix = zeros(numberOfRows,numberOfColumns);

%Initialize the quit and repeat signals
quitSignal = 0;
repeatSignal = 1;

%Generate and write random matrices to the server socket every 3 seconds
for i = 1:pObj.numberOfMatrices
    %Generate a random matrix
    randomMatrix = rand(numberOfRows,numberOfColumns);
    
    %Write the matrix to the server and prompt the client side to continue
    %reading from the server
    fwrite(tcpIpServer,randomMatrix(:),'double');
    fwrite(tcpIpServer,repeatSignal,'int8');
    pause(3);
end

%Write a matrix to send and terminate the connection on the client side
fwrite(tcpIpServer,quitMatrix(:),'double');
fwrite(tcpIpServer,quitSignal,'int8');

%Close the server
fclose(tcpIpServer);