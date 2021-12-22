#!/bin/bash

states=('california' 'hawaii' 'oregon' 'nevada')

for state in ${states[@]};
do
	if [ $state == 'hawaii' ]
	then
	echo 'Hawaii is the best!'
else
echo "I'm not fond of Hawaii"
fi
done
