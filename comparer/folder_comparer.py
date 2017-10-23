import os
import sys
import time
import hasher

currect_directory = os.getcwd()
sha_script_path = os.path.join(currect_directory, 'sha1.py')

def compute_hash(my_directory):
    for file in os.listdir(my_directory): # returns list
        sub_directory = os.path.join(my_directory, file)
        if os.path.isfile(sub_directory):
            hasher.sha1(sub_directory)
        else:
            compute_hash(sub_directory)
    return

path = sys.argv[1]
if path[-1:-2] != '/':
    path = path + "/"
path = os.path.dirname(path)

#file = open(“testfile.txt”,”w”) 
compute_hash(path)