#!/bin/bash

output="~/if_then_output.txt"

if [ -d ~/research ]
then
	echo The research directory exists!
else 
	mkdir -p ~/research
fi

if [ -f ~/research/sys_info.txt ]
then 
	echo sys_info.txt is not there!
else
	rm sys_info.txt
fi
