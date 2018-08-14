#!/usr/bin/python
# -*- coding:utf-8 -*-

from __future__ import print_function
from __future__ import unicode_literals
import os, sys

def help_():
    print(
"""DOT:
    Naive dotfiles management util by geneLocated

usage:
    `make [option] topic=[topic]` or
    `python {filename} [options] [topic]`

options:
    help:		Display this message
    list:		List exist topics
    list [topic]:	List .files under this topic
    apply [topic]:	Apply a topic""".format(filename=sys.argv[0])
        )

def list_():
    if len(sys.argv) < 3:
        # list topics in this repo
        print(_gettopic())
    else:
        # list dotfiles under a topic
        print(_getfiles(_prefixtopic(sys.argv[2])))

def _prefixtopic(topic):
    """prefix with 'topic.' if not given"""
    return topic if topic.find('topic.') != -1 \
        else 'topic.' + topic

def _gettopic():
    file_and_dir = os.listdir('.')
    dironly = [i for i in file_and_dir \
        if os.path.isdir(os.path.join('.', i))]
    topics = [i[6:] for i in dironly if i.find('topic.') == 0]
    return topics

def _getfiles(topic):
    os.chdir(os.path.join('.', topic))
    dirs = os.walk('.')
    # os.walk returns a list of tuples,
    # every tuple is (root: str, dirs: list, files: list)
    # files = [f for i in dirs for f in i[2]]
    files = [os.path.join(i[0], f)[1:] for i in dirs for f in i[2]]
    os.chdir('..')
    return files

def apply():
    if len(sys.argv) < 3:
        print('Missing topic, operation failed.')
    else:
        topic = _prefixtopic(sys.argv[2])
        for target in _getfiles(topic):
            ori = os.path.join(os.getcwd(), topic, target[1:])
            print(ori)
            print(target)
            # make dir if not exist
            dir = os.path.split(target)[0]
            if not os.path.isdir(dir):
                os.makedirs(dir)
            # backup the file if already exist
            if os.path.isfile(target):
                os.rename(target, target + '.BAK')
            os.system('ln -s {ori} {tar}'.format(ori=ori, tar=target))



if __name__ == '__main__':
    # print(sys.argv)
    # display help if no args provided
    if len(sys.argv) < 2:
        help_()
    else:
        {'help': help_,
         'list': list_,
         'ls': list_,
         'apply': apply}[sys.argv[1]]()
