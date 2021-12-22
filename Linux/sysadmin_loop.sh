#!/bin/bash

users=('/etc/shadow' '/etc/passwd')
output=~/output.txt

#Loop through all of the files in our files list
for u in ${user[@]};
      do
# list each file in the files list, append to output var
      ls -l $u >> $output
done      

for user in $(ls /home);
do
	sudo -lU $user
done

command=("date" "uname -a" "hostname -s")

for c in "${commands[@]}";
do
	echo -e "The results of the $c are $($c)"
done	
