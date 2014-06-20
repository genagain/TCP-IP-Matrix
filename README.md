TCP-IP-Matrix
=============
In this assignment, I wrote a Matlab script that builds a TCP/IP communication between two Matlab sessions.  In one session the server script is executed and 

in the other the client script is being executed.  Every three seconds, random NxM matrix is generated in the server session and being transmitted to the 

other session.  In client session receives the matrices from the server and then visualizes the data.  The data visualization is updated periodically as new 

data is being received.  To change the dimensions of the matrices being generated open the MatrixDimensions.m file and change the values for the variables 

numberOfRows and numberOfColumns depending on how many rows and columns are desired for matrices that are generated.  To run change the 

Instructions before running the program:
Because this assignment requires TCP/IP protocols, the IP address for the MATLAB server socket must be static.  Otherwise this program would not be able to 

create a client connection to the server socket.  

To set the IP address, do the following steps:
1.	Open the command prompt and type ipconfig /all
2.	Open the control panel
3.	Copy the following path the bar to the left side of the search bar and press enter
a.	Control Panel\Network and Internet\Network and Sharing Center
4.	Click Local Area Connection
5.	Click Properties
6.	Click Internet Protocol Version 4 (TCP/IPv4)
7.	Click Properties
8.	Select the Use the following IP address radio button
9.	Copy the IP address, the Subnet mask and the Default gateway from the command prompt
10.	Select the Use the following DNS server addresses radio button
11.	Copy the DNS server to the Preferred DNS server from the command prompt
12.	Press Okay, then close and then close.
13.	Open the Client.m file
14.	On line 11, change the IP address (in this case it’s 129.10.53.156) to the IP address you set
15.	Save the file 

To run the program, do the following steps:
1.	In the command prompt, go to the directory where the program files are saved.  
2.	Then type matlab –r “Server”
3.	This will open Matlab and run the Server script

If you want to run the program without using the command prompt, you can run the Server script inside Matlab.
