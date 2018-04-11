import os
import fnmatch
import subprocess
import time
import threading

def find_au3s():
   return [os.path.join(dirpath, f)
      for dirpath, dirname, files in os.walk(os.getcwd())
      for f in fnmatch.filter(files, "*.au3")]

def check_Exe(au3):
   name = os.path.splitext(au3)[0]
   cmd = "wine " + name + ".exe"
   run_command(cmd)

def invoke_Aut2Exe(au3):
   name = os.path.splitext(au3)[0]
   if os.path.exists(name + ".exe"):
      os.remove(name + ".exe")
   cmd = "wine ./Aut2exe.exe /in " + name + ".au3 /out " + name + ".exe"
   run_command(cmd)

def run_command(cmd):
   print ("cmd: %s" % cmd)
   output = ""
   error = ""
   process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
   try:
      output, error = process.communicate(timeout=60)
   except subprocess.TimeoutExpired:
      process.kill()
      output, error = process.communicate()

   if process.returncode != 0:
      print ("output: %s" % output)
      print ("error: %s" % error)
   else:
      print("cmd completed!")
   

if  __name__ == "__main__":
   au3s = find_au3s()
   for au3 in au3s:
      invoke_Aut2Exe(au3)
      check_Exe(au3)
