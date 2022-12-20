from ast import Module
import os
import string
import hcl2
import dictdiffer
import pprint

import TfFile
import TfModuleFile

'''
extract module var
return value list
    ex) [[trash, value, method, path, filename]. ...]
        [['', '${bool}', 'create_vpc', '/InitCloud/scan/custom-terraform-aws-vpc', 'variables.tf']
        ['', '${string}', 'name', '/InitCloud/scan/custom-terraform-aws-vpc', 'variables.tf']...
'''
def ext_module_var(ModulePathList:list):
    VarPath = []
    VarRes = []
    for TmpModulePathList in ModulePathList:
        VarPath.append(TfFile.file_path(TmpModulePathList + " -maxdepth 1 "))              # search current dir
    for TmpVarPath in VarPath:
        VarRes.append(TfModuleFile.ext_using_method(TmpVarPath, "variable", "default"))
    return VarRes



