#!/usr/bin/python

from __future__ import print_function
import os, sys

def help():
    print(
'''DOT:
    A dotfiles management util by geneLocated

usage:
    `make [option] [topic]` or
    `python ./dot.py [options] [topic]`

options:
    help:		Display this message
    list:		List exist topics
    list [topic]:	List .files under this topic
    apply [topic]:	Apply a topic'''
        )

def list():
    if len(sys.argv) < 3:
        # list topics in this repo
        print()
    else:
        # list dotfiles under a topic
        print()
        mypath = os.getcwd()
        file_and_dir = os.listdir(mypath)
        fileonly = [f for f in file_and_dir \
                    if os.path.isdir(os.path.join(mypath, f)]

def apply():
    if len(sys.argv) < 3:
        print('Missing topics, operation failed.')
    else:
        print()



if __name__ == '__main__':
    # display help if no args provided
    if len(sys.argv) < 2:
        help()
    else:
        {'help': help,
         'list': list,
         'apply': apply}[sys.argv[1]]()
