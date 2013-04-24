#!/usr/bin/env python

'''
Gf2 tools.
Example:
  python gf2.py clean: clean up all generated folders and files.
  python gf2.py build: Compile js and css files.
  python gf2.py deploy --instance=[prod|dev]: Deploy the application.

This scrip requires a config file at same directory '.gf2'. See commends on '.gf2-example'.
'''
import os.path
import argparse
import subprocess
import shutil
import os
import re

gf2config = {}
args = None

def clean():
  print('cleaning...')
  _rm_if_exist('web/app/packages')
  _rm_if_exist('web/app/web/out')
  _rm_if_exist('web/app/web/test/out')
  _rm_if_exist('web/app/pubspec.lock')
  print('cleaned up!');

def parse_pages(file):
  pages = []
  with open(file) as f:
    for line in f:
      m = re.search('\'(.*)/([^/]*)\.html', line)
      if m:
        pages.append((m.group(1), m.group(2)))
  return pages

def build():
  clean()
  print('building...')
  os.chdir('web/app')
  _run_command('pub install')
  _run_command('dart build.dart')
  pages = parse_pages('build.dart')
  print('running dart2js for pages: %s' % pages)
  for dir, p in pages:
    _run_command('dart2js %s/out/%s.html_bootstrap.dart -o%s/out/%s.html_bootstrap.dart.js' % (dir, p, dir, p))
  os.chdir('../../')
  print('g2f built!')

def deploy():
  build()
  application_id = gf2config['prod-application-id'] if args.instance == 'prod' else gf2config['dev-application-id']
  with open('web/gf2app.yaml') as f:
    appconfig = f.read().replace('APPLICATION_ID', application_id)
    with open('web/app.yaml', 'w') as appcofig_file:
      appcofig_file.write(appconfig)
  print('new app.yaml generated with application id %s.' % application_id)

  'Confirm before deploying to prod env.'
  if args.instance == 'prod':
    resp = raw_input('Are you sure to deploy to prod env? y/n\n')
    if resp != 'y' and resp != 'Y':
      print('Deploy to prod env canceled!');
      return

  if args.instance == 'local':
    _run_command('dev_appserver.py web/ --port 8080 --enable_sendmail')
  else:
    _run_command('appcfg.py update web --email=%s' % gf2config['email'])
  
def _run_command(cmd):
  print(cmd)
  print(subprocess.check_output(cmd.split()))

def _rm_if_exist(path):
  if os.path.exists(path):
    if os.path.isdir(path):
      shutil.rmtree(path)
    else:
      os.remove(path)

def _check_tool(tool_name):
  rc = subprocess.call(['which', tool_name])
  if rc != 0:
    return False
  return True

def _load_gf2config():
  gf2config_file = open('.gf2')
  for line in gf2config_file:
    if not line.isspace() and not line.startswith('#'):
      segs = line.strip().split('=')
      assert len(segs) == 2, 'WTF is %s, it should be in the format a=b.' % line
      gf2config[segs[0]] = segs[1]
  print('gf2 config loaded:', gf2config)

actions_map = {'clean': clean,
               'build': build,
               'deploy': deploy}


if __name__ == '__main__':
  assert _check_tool('pub'), 'hey, pub not found, add dart SDK into your $PATH'
  assert _check_tool('dart2js'), 'hey, dart2js not found, add dart SDK into your $PATH'
  assert _check_tool('dart'), 'hey, dart not found, add dart SDK into your $PATH'
  assert _check_tool('appcfg.py'), 'hey, add GAE python SDK into you $PATH'
  _load_gf2config()
  parser = argparse.ArgumentParser(description='gf2 tools.')
  parser.add_argument('action', help = 'clean, build, deploy', choices = ['clean', 'build', 'deploy'])
  parser.add_argument('--instance', help = 'Specify the instance you wanna deply to. Instance name is defined in .gf2', choices = ['dev', 'prod', 'local'])

  args = parser.parse_args()
  actions_map[args.action]()
