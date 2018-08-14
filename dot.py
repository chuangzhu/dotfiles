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
    `make <command> [args=<args>]` or
    `python {fn} <command> <args>`

commands:
    help:		Display this message
    list:		List exist topics
    list <topic>:	List .files under this topic
    apply <topic>:	Apply a topic of .files (by making soft links in some directory)

    add <file> ...:	Stage files you want to backup to a temporary buffer
    status:		Display files you staged and the topic you are going to commit to
    select <topic>:	Select the topic you would like to commit to
    select:		Cancel selecting topic
    commit:		 Store buffer data to a topic you `select`, you may want to run `{fn} apply <topic>` to make links in your directories

operation flow:
    to backup:
        [{fn} select] -> [{fn} add] -> ... -> [{fn} add] -> [{fn} commit] -> [{fn} apply] -> [git add .] -> [git commit]
    to restore:
        [{fn} apply]

HINT:
    These files and dirctories are temporary. Instead of tracking them in your repo, add them in `.gitignore`:
    /BUFFER/
    /SELECTEDTOPIC""".format(fn=sys.argv[0])
    )

def list_():
    if len(sys.argv) < 3:
        # list topics in this repo
        print(_gettopic())
    else:
        # list dotfiles under a topic
        print(_getfiles(_prefixtopic(sys.argv[2])))

def _prefixtopic(topic):
    """Prefix with 'topic.' if not given"""
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
    """Apply a topic."""
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

def select():
    """Select a topic to commit."""
    if len(sys.argv) == 2 and os.path.isfile('SELECTEDTOPIC'):
        os.remove('SELECTEDTOPIC')
    elif len(sys.argv) == 3:
        with open('SELECTEDTOPIC', 'w') as f:
            f.write(_prefixtopic(sys.argv[2]))
            f.flush()

def add():
    """Add file(s) into the buffer."""
    if len(sys.argv) == 2:
        print('Nothing specified, nothing added.')
    else:
        from shutil import copy
        for f in sys.argv[2:]:
            # remove root slash
            dir = os.path.join('BUFFER', f[1:])
            if not os.path.isdir(dir):
                os.makedirs(dir)
            copy(sys.argv[2], os.path.join(dir))

def status():
    if os.path.isfile('SELECTEDTOPIC'):
        print('Selected topic:')
        print('  (use `{} select` to unselect)'.format(sys.argv[0]))
        with open('SELECTEDTOPIC', 'r') as f:
            print(f.read())
    else:
        print('No topic selected.')
    print()
    if os.path.isdir('BUFFER') and len(_getfiles('BUFFER')) != 0:
            print('Files staged in the buffer:')
            print(_getfiles('BUFFER'))
    else:
        print('Nothing in the buffer.')

def _topicfy():
    with open('SELECTEDTOPIC', 'r') as selected:
        topicname = selected.read()
        # shutil.move is easy to use!
        from shutil import move
        move('BUFFER', topicname)
    os.remove('SELECTEDTOPIC')

def commit():
    """Commit the files in the buffer to the selected topic.
    Create one if not exist.
    """
    if not (os.path.isdir('BUFFER') and len(_getfiles('BUFFER')) != 0):
        print('Fatal: no file staged in the buffer')
        print('  (use `{} add <file> ...` to stage files)'.format(sys.argv[0]))
    elif not os.path.isfile('SELECTEDTOPIC'):
        print('Fatal: no topic selected')
        print('  (use `{} select <topic>` to select a topic)'.format(sys.argv[0]))
    else:
        _topicfy()



if __name__ == '__main__':
    # print(sys.argv)
    # display help if no args provided
    if len(sys.argv) < 2:
        help_()
    else:
        {'help': help_,

         'list': list_,
         'ls': list_,
         'apply': apply,

         'select': select,
         'add': add,
         'status': status,
         'st': status,
         'commit': commit,
         'ci': commit}[sys.argv[1]]()
