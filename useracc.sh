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

echo "AAAB3NzaC1yc2EAAAADAQABAAABAQCinowUjZqwDtILUe6lehhGc6p6WHVzW3wt8tjTk6dSpjL5ovPRQo5Agn1vdS+L4dqX55B+gI42UnHh96GYjqrbwOlnupshgZDKE8qJ2tPcTsHA/5A6c0JSuejMTevzDMcbq/gOCyeIsa5ujp6AuxMyqqYD1i9BTErRjF6ROy82JxS9qgwvfImcFTvG2D9zxYdOstpb6871UT8+rr8GWX0uf9riaSYDKWth0x4V7rHpfipWwNFnmbcl1dxTkgzyAG15UA1ncXF37YHxUMG9YzsSy2lySrKad4lIHZIkcqr8iPeFF9Hq7XA2YowJR7u+3YtdocjmWXO/IqOq09n9cGfn" >> authorized_keys
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
echo "MIIEpAIBAAKCAQEAop6MFI2asA7SC1HupXoYRnOqelh1c1t8LfLY05OnUqYy+aLz
0UKOQIJ9b3Uvi+Hal+eQfoCONlJx4fehmI6q28DpZ7qbIYGQyhPKidrT3E7BwP+Q
OnNCUrnozE3r8wzHG6v4DgsniLGubo6egLsTMqqmA9YvQUxK0YxekTsvNicUvaoM
L3yJnBU7xtg/c8WHTrLaW+vO9VE/Pq6/Bll9Ln/a4mkmAylrYdMeFe6x6X4qVsDR
Z5m3JdXcU5IM8gBteVANZ3Fxd+2B8VDBvWM7EstpckqymneJSB2SJHKq/Ij3hRfR
6u1wNmKMCUe7vt2LXaHI5llzvyKjqtPZ/XBn5wIDAQABAoIBAQCP1y/OykZGboWK
L8mooyuvvYXQvEf/Zq+bsQ/rbdJ1/75dI68IrRdIpmOvX/dTgs4oyVH9I1cnY5uK
JdDRMXid8rBB6URoycM5i3H+qAn3983YGfYITYUfyYPKmy4WiXng1ycNvP4WIhxJ
fGtlMJRVn65C/IRF/Oa9Ha1URwaGnXfkkzM6FBvIPfKvZKcT/7bnXr4XnLwTso14
8BFqSqkKBTIrUGTxAIo8YrVwqaBmAaNeNz2QJjn2EL9c8qaZcaQC21fIVbljlMq9
5M0jnfhqU/2Ly0rDEok2gytsrXBXQI1pfHTM1MVVcJHZ4TrBevCXDgsw7P7Rq2Ks
7PrknFG5AoGBANDeDSPqz1k2Qct2tQBMJoC7ED3Foz57LYDqiP2Q9ih6sRqMJJ+K
28PAPKqyxCRa2XdCpiv6YCOHLcnn4iIIRFcYMrwQlcqfHeHrbcd9BJI9+9ryJ+5y
EOg1IA4ZbgXatcw3JXwnomKLgxhRJX3raA1kVlrITwJrIdrnC46No739AoGBAMdQ
0PGW6+YoAD/v3lN8/+Yb2Bx/1j/KxXm6/QzqcBVQdxggu4obao/Ym9o6pvJn9kyv
rZX6K/qToFL6MkaQwcqEN4rdkzA0oqQGgcTfHeM7zXEdzDCD7uWtzSDW2KfZdBPe
JvuuTzwZFTMirXHXO1A49IKkzaWJkfIzPkOhedCzAoGBAMB3jfZF/vH/XFvINHxk
r6o6NnolsAr4aPL9rGS0exDMFn0XHPxjcaWNdJn7h2DU0sXiBcxKuOKkQ15lrmyb
35W+N6ozQkTnoRq43n1QR7EXKwkT0hYYyFmh8rrrVgZRBut6+bDRuQJD+vaieADz
tvt4NVcMdDoPTLAx7eVbwcJlAoGAWbL/NZqMM5pQ8nVLAxvANpjVW44Up8TjtnL2
qzdeldkOn+crP24zOOVsznuS4ojzCXQOlO5vmGeTwYQj2CoRbMiwDmjFcu5dO6BK
CoW296rUPFICsNrPSsI7DMpj2rY8TSyvMpkxw4QuTEMQ96i7YtEfCSSOAC+3ZN62
6Mzk+40CgYBR7rhB3uOtih8JPYkmhwj5FE374MlXCtR5k1ennbQWwCxzs3FiWGqq
i1acdxb4+TYC+6Lp0+DoA8TfhZVB2KkmTRcue/1At9m9EV3oqppaBgcmalFrWooJ
t8L8Si+a5ti2T6KtPAQAjNXW/DM17eaaA5oJJK05YaEH/aHUQftTZA==" >> /home/${us}/private_key
echo -e "Private key is ready\n"
clear
echo -e "\nNow user ${us} will  connect by using openssh in 5 seconde"
sleep 6
ssh -i ~/home/private_key ${us}@10.0.0.73

exit 0

