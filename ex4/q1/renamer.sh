#!/bin/bash

#author: Haim 

format=$1
path=$2
counter=0

function Usage {
    echo "USAGE: First parameter for Extension Second one for Directory"
}

if [[ $format == "" || $path == "" ]]; then
    echo "Format or path is empty!"
    Usage
    exit 1
fi

if [ ! -d "$path" ]; then
    echo "Directory doesn't exist!"
    Usage
    exit 2
fi

cd $path

if [ -z "$(ls)" ]; then
    echo "Directory is empty!"
    exit 3
fi

for file in *; do
    if [[ ($file == "renamer.sh") || (! -f $file) ]]; then
        continue
    fi

    filename=$(basename "$file")
    extension="${filename##*.}"
    if [[ $extension == $format ]]; then
        continue
    fi

    filename="${filename%.*}"
    mv $file "$filename.$format"
    counter=$[counter + 1]
done

echo "Successfully renamed $counter file(s)!"