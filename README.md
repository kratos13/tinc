# tinc
tinc, the lightweight VPN server.


I really owe a few people for getting me on to #tinc. Special thanks to rtasson and ptdel. 


   This script will essentially get you set up with :
* Creating the VPN name - $VPN
* Creating a client - $CLIENT_NAME


   This script will create all the necessary files, but will still require you (as the user) to append a few additional files. For the most part, you will need to specify the 'ConnectTo' option in the 'tinc.conf' file. On each of the clients, you will need to ensure that they connect each client you wish to have be part of your $VPN network. Once you have the tinc.conf file appended, you will then need to copy the client's 'host' file to each other client. The host file is located in /etc/tinc/$VPN/hosts/    They will need to have '0644' permissions (already performed by the script'. 


   # Example of my tinc.conf #

Name = cronus \n
Mode = switch \n
ProcessPriority = high \n
LocalDiscovery = yes \n
ConnectTo = pollyanna \n


   Where 'cronus' is the name of my $CLIENT_NAME and 'pollyanna' is the other host I am trying to connect to. So, on pollyanna, it would have a 'ConnectTo = cronus'

