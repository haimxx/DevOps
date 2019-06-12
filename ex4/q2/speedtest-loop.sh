#!/bin/bash

#author: Haim 

count=$1
interval=$2

function Usage {
    echo "USAGE: First parameter for running count(0 for endless) Second one for interval"
}

if ! [[ $count =~ ^[0-9]+$ ]]; then
    echo "Count value is not an integer or empty!"
    Usage
    exit 1
elif ! [[ $interval =~ ^[0-9]+$ ]]; then
    echo "Interval value is not an integer or empty!"
    Usage
    exit 2
fi

if [ -f "output.csv" ]; then
    echo "Output file already exists"
    echo "Would you like to overwrite it? (y/n)"
    read answer
    while [[ $answer != [yYnN] ]]; do
        echo "Wrong input: y/n"
        read answer
    done
    if [[ $answer == [nN] ]]; then
        echo "Exiting..."
        exit 0
    fi
fi

start=$SECONDS

echo "Date,Time,Download,Upload" > output.csv
for ((i=0; i<$count || $count==0; ++i)); do   
    output="$(date +%d.%m.%Y),$(date +%X)"    
    speed="$(speedtest-cli --simple)"

    #Download parsing
    output="$output,$((echo -e "$speed" | awk 'NR==2') | (cut -d " " -f 2))"

    #Upload parsing
    output="$output,$((echo -e "$speed" | awk 'NR==3') | (cut -d " " -f 2))"

    echo $output >> output.csv
    sleep $interval
done

echo "Total running time $(( SECONDS - start )) seconds"