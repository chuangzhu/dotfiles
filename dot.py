#!/usr/bin/python
# -*- coding:utf-8 -*-

from __future__ import print_function
from __future__ import unicode_literals
import os, sys

def help():
    print(
'''DOT:
    A naive dotfiles management util by geneLocated

usage:
    `make [option] topic=[topic]` or
    `python {filename} [options] [topic]`

options:
    help:		Display this message
    list:		List exist topics
    list [topic]:	List .files under this topic
    apply [topic]:	Apply a topic'''.format(filename=sys.argv[0])
        )

def ls():
    if len(sys.argv) < 3:
        # list topics in this repo
        print(_gettopic())
    else:
        # list dotfiles under a topic
        print(_getfiles(sys.argv[2]))
        

def _gettopic():
    file_and_dir = os.listdir('.')
    dironly = [i for i in file_and_dir \
        if os.path.isdir(os.path.join('.', i))]
    topics = [i[6:] for i in dironly if i.find('topic.') == 0]
    return topics

def _getfiles(topic):
    dirs = os.walk(os.path.join('.', topic))
    # os.walk returns a list of tuples,
    # every tuple is (root: str, dirs: list, files: list)
    # files = [f for i in dirs for f in i[2]]
    files = [os.path.join(i[0], f) for i in dirs for f in i[2]]
    return files

def apply():
    if len(sys.argv) < 3:
        print('Missing topics, operation failed.')
    else:
        for i in _getfiles(sys.argv[2]):
            os.system('ln -s {}'.format(i))



if __name__ == '__main__':
    # print(sys.argv)
    # display help if no args provided
    if len(sys.argv) < 2:
        help()
    else:
        {'help': help,
         'list': ls,
         'ls': ls,
         'apply': apply}[sys.argv[1]]()
