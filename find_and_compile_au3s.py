import os
import fnmatch

def find_au3s():
   return [os.path.join(dirpath, f)
      for dirpath, dirname, files in os.walk(os.getcwd())
      for f in fnmatch.filter(files, "*.au3")]

def invoke_Aut2Exe(au3s):
   for au3 in au3s:
      name = os.path.splitext(au3)[0]
      if os.path.exists(name + ".exe"):
         os.remove(name + ".exe") 
      cmd = "wine /local/workspace/jenkins/Aut2exe.exe /in " + name + ".au3 /out " + name + ".exe"
      print ("cmd: %s" % cmd)
      os.system(cmd)
   

if  __name__ == "__main__":
   au3s = find_au3s()
   invoke_Aut2Exe(au3s)
