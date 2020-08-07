#!/bin/bash
# Description: Check users
# author: Ruben
# Date: Aout 2020

############################################### Phase1 ###############################################################
#1-Create a scrip that will prompt User's name
echo -e "\nPlease enter your username"
read us

#2-Base on the name of the user the shell script will create the user on the system
#before the let the system run , to avoid error let's put condition in case the user is already on the system
id ${us} > /dev/null 2>&1
if [ $? -eq 0 ]
then
echo "User exist"
else
echo -e "\nUser does not exist in the system...do yo want to create it? (yes/no)"
read ans
sleep 5
      if [ ${ans} == yes ]
      then
      useradd ${us}
echo "User successfully created"
      else
echo "Thank you for stopping by"
      exit
      fi

fi
echo -e "\nCreate your password\n"
passwd ${us}
sleep 3
#3-Ensure that the user that's being created also has default home folder
echo -e "\nCheck if ${us} in the /home/ Directory\n"
sleep 3
grep "${us}" /etc/passwd |awk -F"::" '{print $2}' |awk -F":" '{print $1}'
#I use the awk command the filter my result

############################################### Phase2 ###############################################################
#Update your script base on the created users,Ensure that the folder .ssh exist in the users home directory
echo -e "\nCheck if .ssh is on the ${us}'s home directory\n"
if [ -d "/home/${us}/.ssh" ]
then
echo -e "\nDirectory /home/${us}/.ssh exist\n"
else
echo -e "\nDirectory /home/${us}/.ssh does not exist. let's create it\n"
sleep 5
mkdir -p /home/${us}/.ssh
echo -e "\nNow the folder .ssh is available in the /home/${us} directory\n"
fi

############################################### Phase3 ###############################################################
#1-Within the .ssh folder, create a file call "authorized_keys" 
echo -e "\nCreating the file authorized_keys\n"
sleep 3
touch /home/${us}/.ssh/authorized_keys
sleep 5
echo -e "\nFile has been created\n"
#Now let add the public key inside the file
echo -e "\nAdd the public key now\n"

echo" no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command="echo 'Please login as the user \"ubuntu\" rather than the user \"root\".';echo;sleep 10" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCQ3h2pVyXCuzYOKsH++Z24OmF/lJb9nT0rs67qtxMuUkgmFnH9r66puDSV3cOR1zoQ6A0i4RWMufH86mcru7HTLjS6wjkBq8FdTRrQCRvtiEMxf+qnFoHJ2dH2LMUcZyWkOz1+f94kLU35y48FE2JzpSQo+9sLgqhvi1FEiNYHab5rI65hubb0bSsRlYHXW+whUJiEGweMKVPUgxo0DHy6l1yR3kqk39Z/9Fr/eIzSkRN83GAvmDx5YvNu9AIVhVMj+Lx+0crCK01pMiZwTnlpeXJZcDIaTxt+JjfeHcOO8CLefIttT8r64fgpwXg3W6vnr6LeF7gE6RrXddyHgu+b BOB
" >> authorized_keys
#cat authorized_keys
sleep 3
echo -e "\nThe key has been Added\n"

#Using the private key below , ensure that you are able to connect on each user  account by using OPENSSH
#LET CREATE A FILE CALL PRIVEAT KEY IN PUT THE KEY INSIDE THE FILE
echo -e "\nCreate a file for the private key\n"
sleep 5
touch /home/${us}/private_key
echo -e "\nFile has been created on the home directory of each users\n"
echo -e "\nNow let put the key in the file\n"
sleep 6
echo "MIIEpAIBAAKCAQEAyr/ZLW9J7bBlWsG19U1RpQ1HcRknsCQUTjXpfSXrS+nB8hm6
ZyP3N0HnFTTKkaGsrKLaGrhpX4g7Lwl3CswiESECMmUUxM3nqr+P1oMOh9HmKpgE
cJbnjhmkfrSrtJuA1ycxTveRnKemDFMGTXPnaw7teTlScmAfFy9NPfuKP2+Z5BzJ
o0VwaSTsa38qPWTALSOLb04Ly9waFOTfvNZgYeZBEoAcK8MYuK823r027iUUTTPu
+ttLORG8LNciWgLnuP23WUYgSTeqGRnjC1Q1Pw2a0ZDwplv6LH15PkmQwgHmxvDT
aW9Tc7U1OtgbjUTEMBlNTv0c9XNpO5B9ajqLowIDAQABAoIBAExXosoV3otuYSuk
RwR/wZ9Zea4fX69WVoMAj9N8xLWH5mxnvaV6iGq5GO8GOsRNUTyL8X4gNCUxob9b
XASnyqgSesZJA2H7eiD0EpAeNwlzQqyFIx7V44jBJQxEsWbHKuNYsZtfYufOxJpd
ZMEjRF8udsKvj9jbUrmjKP2OyoaJrX4u+YJwO2hbdOvS8w3PuMoDkKaC2F9nD02s
uvDx+uDVkYxviCNqq36rbLvTHoBjHkSFO9xiAxiKzbpyuAwIBoaNjP1sv+v2mPzz
X5aRFgTcBi36coIQ1LXkl9AINUX9GZrOnF0zvI8CGoVN7XzVOURE12Yzqn3mal2o
XhmfGKkCgYEA/5810JpTSWYqjmxcp2wuftqllAM+RFKaWiuPXCdlwWcq/thXJLbW
AxuEw3a6mjnV74zeE6/9PGK3hH8sDaknJ4WFjwbjwPsHemzFZWpGmY2srIm9Vkkw
vfUFin83Jksddb4C0q5p/id80OUl+fmUWVECgs9x/0SK6DOCJDJPCB8CgYEAywye
RlaD5hW3BBzzfJ21ClUM/yu01M09kmyQsQPXWLUomNcGYk9P1fSRYLWunt4ERxp9
qw6jGOztZsYdgFLzsDLDXRWbAsrzikY29e1Q6KiMxWLYLEJOl51hPL4DeV6vlGai
11m4w9NIh0fXgs4JIpnPY9YaikfR+q/egYgz2/0CgYEAjzw0WH6RWtiv0fywcnQx
HY4BKA4lLv2mVg6Al1/QKe5YblLlicIV68nYu/pkl5T+5utlaVy9JsAeG1VzZvg4
43FzJHD04CcJyrT2a1yA0PxNHKVV/eqnMFoCz9d3HLMMf/SH+mwXIn4X96nffNI4
KVA2evwo4aQTvgdWzleOZ3sCgYAqItQ1hH6aoKb6E4fztEZ9fmjUCx3bizvbxuu/
0CxAHFfwX67Td+H5ZGdGym0SSsBYgQbTGJZ/9arOSQ6WMqCfT+l6x6EDU1p2t1tw
bW782P1deMWjaZ8ll2M2V7gg16VYBnSEe/n7qTzD1gTDAD6lD4YaEbQwPfc1Lone
F4WrgQKBgQCjX6GBAH12QoFXnxdFDi0rKHun50IyCknlVrmmoaZh9/L4s63L7SJG
knFrkqWtwp3kCyLEMio7P0IBRQ179X1F0vz0n054JxJ94GfZbTVS2YPwu2yf/FAR
xIoJSTXiuoO6avufPO9vgX3seX4qdWr2Q64wCXb4cTphhsKLIV5ELw== " >> /home/${us}/private_key
echo -e "Private key is ready\n"
clear
echo -e "\nNow user ${us} will  connect by using openssh in 5 seconde"
sleep 6
ssh -i ~/home/private_key ${us}@10.0.0.73

exit 0

