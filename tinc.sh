#!/bin/bash

##########
##
##
##
##   tinc vpn
##
##   a sweet, light-weight vpn server//client
##   fist bash script ever. 
##
###########
###########
clear
echo "Hello, "$USER".  This will {obviously} intall tinc, the lightweight VPN package. Please run as root."
sleep 5

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "'Please run as root.'" 1>&2
   exit 1
fi

# Update the system as rootm
# apt-get update && apt-get install tinc

# change to home directory
cd /etc/tinc

echo " "
echo " "
# Make a directory
echo -n "Enter your desired name for your VPN and press [ENTER]: " 
read VPN
mkdir -p "./$VPN" 
mkdir -p "./$VPN/hosts/"

# Create the 'boot' file
touch nets.boot && echo ""$VPN"" > nets.boot


cd /etc/tinc/$VPN/

## Create up sript ##
touch tinc-up

echo " "

## Linux config  ##
##  NEED TO CREATE A 'valid' IP INPUT
echo -n "What would you like your VPN_IP to be {{this will be a /32}}?" 
echo " "
echo "** Please do not be dumb... create an IP from a subnet not in use.  {{ex: 10.67.68.X}} "
read VPN_IP
echo -e '#!/bin/bash' >> tinc-up
echo -e 'ifconfig $INTERFACE' $VPN_IP 'netmask 255.255.255.0' >> tinc-up 
echo -e 'ifconfig $INTERFACE up' >> tinc-up

sleep 2

## Create down script ##
touch tinc-down
echo -e '#!/bin/bash' > tinc-down
echo -e 'ifconfig $IFCONFIG down' >> tinc-down

echo " " 

## Create the configuration file ##
touch tinc.conf
echo -n "What would you like the name of this client to be? :: "
read CLIENT_NAME
echo -e "Name = $CLIENT_NAME" > tinc.conf
echo -e 'Mode = switch' >> tinc.conf
echo -e 'ConnectTo = <other.client>'  >> tinc.conf
echo -e '#ConnectTo = <some.other.client>' >> tinc.conf
echo -e 'ProcessPriority = high' >> tinc.conf
echo -e 'LocalDiscovery = yes' >> tinc.conf

echo " " 
echo " " 

## Create the VPN-keys ##
echo -n "Creating 4096-bit key ::"
cmd="tincd -n $VPN -K4096"
$cmd 

## Permission the file ##
chmod 644 etc/tinc/$VPN/hosts/$CLIENT_NAME

echo " " 
echo " " 


## VERIFY::
echo -n "Checking the host file {{/etc/tinc/$VPN/hosts/$CLIENT_NAME}}"
cd /etc/tinc/$VPN/hosts/
value='cat ./*'
$value

sleep 2 


### ./tinc start



#Start on boot (Debian) ::
insserv tinc

sleep 2

echo " " 

## Just some additional output ##
echo -n "Alright" 
sleep 2
echo " "
echo -n "Now we have configured $CLIENT_NAME to be part of $VPN. Remember, the 'CLIENT_NAME' for a host can be anything you wish, but the actual network of the VPN {{$VPN}} must remain the same on any other VPN_CLIENT you create. " 
sleep 2
echo " " 
echo -n "Congrats! #tinc is now configured with $CLIENT_NAME. Be sure to copy any additional VPN_CLIENT files to all other clients. If you know how VPN works, this should be pretty easy. Otherwise please see the (evolving) README. Cheers. "
sleep 2 
