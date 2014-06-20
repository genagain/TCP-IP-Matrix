classdef commTags < int8
    enumeration
        %quit - First enumeration
        %This enumeration is used to terminate the connection between the
        %client and server.  When the server sends a 0 integer this
        %enumeration is used to prompt the client script to stop reading
        %data from the server and plot all the data that had been read
        quit                            (0)
        %repeat - Second enumeration
        %This enumeration is used to continue the connection between the
        %client and server.  When the server sends a 1 as a signal, this
        %enumeration is used to prompt the client script to plot the data
        %that is read on the server
        repeat                          (1)
    end
end