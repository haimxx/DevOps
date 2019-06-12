#!/usr/bin/env python3

import os.path
import re
import sys

file_name = "file.txt"
phrase    = "test"

if not os.path.isfile(file_name):
    print("File doesn't exist!")
    exit(1)

with open(file_name,"r") as file:
    for line in file:
        if re.search(phrase, line):
            print(line)
