#!/usr/bin/env python3

#author: Haim

import os.path
import re
import sys


def Usage():
    print("Usage: grep.py phrase path")

    
if len(sys.argv) != 3:
    Usage()
    exit(1)

phrase  = sys.argv[1]
path    = sys.argv[2]

if phrase == "" or path == "":
    print("At least one of the parameters is empty!")
    Usage()
    exit(2)

if not os.path.isfile(path):
    print("File doesn't exist!")
    Usage()
    exit(3)

with open(path,"r") as file:
    for line in file:
        if re.search(phrase, line):
            print(line)