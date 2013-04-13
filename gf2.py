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

gf2config = {}
args = None

def clean():
  print('cleaning...')
  _rm_if_exist('web/app/packages')
  _rm_if_exist('web/app/web/out')
  _rm_if_exist('web/app/pubspec.lock')
  print('cleaned up!');

def build():
  clean()
  print('building...')
  os.chdir('web/app')
  _run_command('pub install')
  _run_command('dart --package-root=packages/ packages/web_ui/dwc.dart --out web/out/ web/app.html')
  os.chdir('web/out')
  _run_command('dart2js app.html_bootstrap.dart -oapp.html_bootstrap.dart.js')
  os.chdir('../../../../')
  print('g2f built!')

def deploy():
  build()
  application_id = gf2config['prod-application-id'] if args.instance == 'prod' else gf2config['dev-application-id']
  with open('web/gf2app.yaml') as f:
    appconfig = f.read().replace('APPLICATION_ID', application_id)
    with open('web/app.yaml', 'w') as appcofig_file:
      appcofig_file.write(appconfig)
  print('new app.yaml generated with application id %s.' % application_id)

  print('appcfg.py update web --email=%s' % gf2config['email'])
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
  _load_gf2config()
  parser = argparse.ArgumentParser(description='gf2 tools.')
  parser.add_argument('action', help = 'clean, build, deploy', choices = ['clean', 'build', 'deploy'])
  parser.add_argument('--instance', help = 'Specify the instance you wanna deply to. Instance name is defined in .gf2', choices = ['dev', 'prod'])

  args = parser.parse_args()
  actions_map[args.action]()
