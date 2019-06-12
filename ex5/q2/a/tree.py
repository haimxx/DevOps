#!/usr/bin/env python3

#author: Haim

import os
import sys


def Usage():
    print("Usage: tree.py path")

    
if len(sys.argv) != 2:
    Usage()
    exit(1)
    
path = sys.argv[1]

if path == "":
    print("Path is empty!")
    Usage()
    exit(2)


if not os.path.isdir(path):
    print("Directory doesn't exist!")
    Usage()
    exit(3)

for root,dirs,files in os.walk(path):
    for file_name in files:
        print(os.path.join(root,file_name))