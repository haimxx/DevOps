#!/bin/bash

#author: Haim 

path=$1

if  [[ "$path" == "" ]]; then
    echo "Path is empty!"
    exit 1
fi

if ! [[ -d "$path" ]]; then
    echo "Path isn't a directory!"
    exit 2
fi

cd $path

if [ -z "$(ls)" ]; then
    echo "Directory is empty!"
    exit 3
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
rm output.csv
fi

start=$SECONDS
i=1
for file in *; do
    output="$i,$file"    
    output="$output,$(md5sum $file | (cut -d " " -f 1))"

    echo $output >> output.csv
    ((++i))
done

echo "Total running time $(( SECONDS - start )) seconds"