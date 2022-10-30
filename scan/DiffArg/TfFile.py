from ast import Module
import os
import string
import hcl2
import dictdiffer
import pprint

'''
current dir -> find file path
return value list 
        ex) [module path, ...]
        ['./cand1.tf', './cand2.tf' ...]
'''
def file_path(path:string):
    TmpPath = os.popen('find ' + path + ' -name "*.tf" 2>/dev/null')
    ResPath = TmpPath.readlines()
    ResPath = list(map(lambda s: s.strip(), ResPath))    # new line character(\n) delete

    return ResPath

