from ast import Module
import os
import string
import hcl2
import dictdiffer
import pprint

# list(list(list(ResFileModules.items())[0][1].items())[0][1][0].items())[0][1], ModuleVarList[0]
def file_diff_in_module(VarResult:list):
    result = []

    for ModuleKey, ModuleValue in VarResult.items():                            # Module Info ex) //custom-terraform-aws-vpc
        temp = list()
        for FileKey, FileValue in ModuleValue.items():                          # File Info   ex) cand1.tf    
            for Method in range(0, len(FileValue)):                             # Method Info ex) vpc   # Method is List / so, key and value do not exist
                temp.append(FileValue[Method].items())
        DiffKey = module_in_diff(temp)
        result.append({ModuleKey : list(DiffKey)})

    return result

def module_in_diff(temp:list):
    result = []

    for i in range(0, len(temp)):
        for j in range(i, len(temp) -1):
            for diff in list(dictdiffer.diff(list(temp[i])[0][1],list(temp[j+1])[0][1])):
                if type(diff[1]) is list:
                    result.append(diff[1][0])
                else :
                    result.append(diff[1])

    return set(result)