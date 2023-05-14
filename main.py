# Imports
import os
import subprocess
import sys
import webbrowser
import argparse
import shlex
#from pathlib import Path

# Commands
def run(command: str, check: bool = None, output: bool = True, cwd: str = None):
    return subprocess.run( shlex.split(command), check=check, stdout=subprocess.DEVNULL if not output else None, cwd=cwd)

# Path

#new_env = os.environ.copy()
#new_env["PATH"] = os.pathsep.join(["./",new_env["PATH"]])

#process_now = subprocess.run(["ls", "-l"],env=new_env)

print('[Flutter]')
print('... => Starting Flutter Doctor')

#command = ["which", "flutter"]

#run(f'flutter', check=True, output=True)

return_code = subprocess.run(['flutter', 'run', "-d", "chrome"], capture_output=True, text=True, shell=True)
print(return_code.stdout)
#return_code = run(f'ls', check=True, output=True)

if return_code == 0:
    print("Command executed successfully.")
else:
    print("Command failed with return code", return_code)

#try:
#    out = subprocess.run(command, shell=True, check=True, capture_output=True, text=True).stdout
#except subprocess.CalledProcessError as e:
#    out = e.output.decode()
#print(out)
#os.system('cmd /k "flutter doctor -v"')
webbrowser.open('https://kbve.com/application/flutter', new=0, autoraise=True)
raise SystemExit("[Flutter] DONE - EOF")
