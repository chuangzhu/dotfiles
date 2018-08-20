#!/usr/bin/python
# -*- coding:utf-8 -*-

from __future__ import print_function
from __future__ import unicode_literals
import os, sys
from os.path import join, isfile, isdir

help_text = """DOT:
    Naive dotfiles management util by geneLocated

usage:
    `make <command> [args=<args>]` or
    `python {fn} <command> <args>`

commands:
    help:		Display this message
    list:		List exist topics
    list <topic>:	List .files under this topic
    apply <topic>:	Apply a topic of .files (by making soft links in some directory)
    recover <topic>:	Stop manage a topic of .files, and try to restore

    add <file> ...:	Stage files you want to backup to a temporary buffer
    status:		Display files you staged and the topic you are going to commit to
    select <topic>:	Select the topic you would like to commit to
    select:		Cancel selecting topic
    commit:		 Store buffer data to a topic you `select`, you may want to run `{fn} apply <topic>` to make links in your directories

operation flow:
    to get files into a fresh management:
        [{fn} select] -> [{fn} add] -> ... -> [{fn} add] -> [{fn} commit] -> [{fn} apply] -> [git add .] -> [git commit]
    to continue managing on maybe some other device:
        [{fn} apply]

HINT:
    These files and dirctories are temporary. Instead of tracking them in your repo, add them in `.gitignore`:
    /BUFFER/
    /SELECTEDTOPIC""".format(fn=sys.argv[0])


def help_():
    print(help_text)


def list_():
    if len(sys.argv) < 3:
        # list topics in this repo
        print(_gettopic())
    else:
        # list dotfiles under a topic
        print(_getfiles(_prefixtopic(sys.argv[2])))


def _rmrootslash(dir_):
    """It is impossible to join '/opt/someplace' and '/home/user/' together
    using os.path.join. We must remove one the root splash of two dirs.
    """
    if dir_[0] == '/':
        return dir_[1:]
    else:
        raise ValueError('do not contain root slash')


def _prefixtopic(topic):
    """Prefix with 'topic.' if not given"""
    return topic if topic.find('topic.') != -1 \
        else 'topic.' + topic


def _gettopic():
    file_and_dir = os.listdir('.')
    dironly = [i for i in file_and_dir
               if isdir(join('.', i))]
    topics = [i[len('topic.'):] for i in dironly if i.find('topic.') == 0]
    return topics


def _getfiles(topic):
    os.chdir(join('.', topic))
    dirs = os.walk('.')
    # os.walk returns a list of tuples,
    # every tuple is (root: str, dirs: list, files: list)
    # files = [f for i in dirs for f in i[2]]
    files = [join(i[0], f)[1:] for i in dirs for f in i[2]]
    os.chdir('..')
    return files


def apply():
    """Apply a topic."""
    if len(sys.argv) < 3:
        print('Missing topic, operation failed.')
    else:
        topic = _prefixtopic(sys.argv[2])
        for target in _getfiles(topic):
            ori = join(os.getcwd(), topic, _rmrootslash(target))
            print(ori)
            print(target)
            # make dir if not exist
            dir_ = _getdir(target)
            if not isdir(dir_):
                os.system('mkdir -p ' + dir_)
            # backup the file if already exist
            if isfile(target) and not isfile(target + '.BAK'):
                os.rename(target, target + '.BAK')
            elif isfile(target):
                os.remove(target)
            os.system('ln -s {ori} {tar}'.format(ori="'{}'".format(ori), tar=target))


def recover():
    """Remove the link file, and recover from the .BAK file"""
    topic = _prefixtopic(sys.argv[2])
    for f in _getfiles(topic):
        if isfile(f):
            os.remove(f)
        if isfile(f + '.BAK'):
            os.rename(f + '.BAK', f)


def select():
    """Select a topic to commit."""
    if len(sys.argv) == 2 and isfile('SELECTEDTOPIC'):
        os.remove('SELECTEDTOPIC')
    elif len(sys.argv) == 3:
        with open('SELECTEDTOPIC', 'w') as f:
            f.write(_prefixtopic(sys.argv[2]))
            f.flush()


def _getdir(fullname):
    """Get dir of a file"""
    return os.path.split(fullname)[0]


def _getshortname(fullname):
    """Get short name of a file"""
    return os.path.split(fullname)[1]


def env_add(string):
    from shutil import copy
    import re
    found = re.findall('{.*?}', string)
    fn_value = string  # /home/user/.vimrc like
    fn_var = string  # ${HOME}/.vimrc like
    # bracketed environment variable
    for bkt_var in found:
        fn_var = fn_var.replace(bkt_var, '$' + bkt_var)
        var = bkt_var[1:-1]  # remove {} brackets
        if var in os.environ:
            fn_value = fn_value.replace(bkt_var, os.environ[var])
        else:
            raise ValueError(
                'environment variable `${}` not exist'.format(bkt_var))
    after = _getdir(join('BUFFER', fn_var))
    if not isdir(after):
        os.makedirs(after)
    copy(fn_value, after)


def add():
    """Add file(s) into the buffer."""
    from shutil import copy
    # environment variable mode
    if ('-e' in sys.argv) or ('--env' in sys.argv):
        argv = sys.argv
        argv.remove('-e') if '-e' in argv \
            else argv.remove('--env')
        for arg in argv[2:]:
            env_add(arg)
        return

    if len(sys.argv) == 2:
        print('Nothing specified, nothing added.')
    else:
        for arg in sys.argv[2:]:
            after = _getdir(join('BUFFER', _rmrootslash(arg)))
            if not isdir(after):
                os.makedirs(after)
            copy(arg, after)


def status():
    if isfile('SELECTEDTOPIC'):
        print('Selected topic:')
        print('  (use `{} select` to unselect)'.format(sys.argv[0]))
        with open('SELECTEDTOPIC', 'r') as f:
            print(f.read())
    else:
        print('No topic selected.')
    print()
    if isdir('BUFFER') and len(_getfiles('BUFFER')) != 0:
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
    if not (isdir('BUFFER') and len(_getfiles('BUFFER')) != 0):
        print('Fatal: no file staged in the buffer')
        print('  (use `{} add <file> ...` to stage files)'.format(sys.argv[0]))
    elif not isfile('SELECTEDTOPIC'):
        print('Fatal: no topic selected')
        print('  (use `{} select <topic>` to select a topic)'.format(
            sys.argv[0]))
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
         'recover': recover,

         'select': select,
         'add': add,
         'status': status,
         'st': status,
         'commit': commit,
         'ci': commit}[sys.argv[1]]()
