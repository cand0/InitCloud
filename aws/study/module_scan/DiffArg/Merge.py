from ast import Module
import os
import string
import hcl2
import dictdiffer
import pprint

import TfFile
import TfModuleFile

def check_duplicate(parent, path, obj) -> dict:
    if path not in parent:
        parent[path] = list()    
    parent[path].append(obj)
    return parent

# ModuleFileList와 FileInModuleVar는 (파일명) - 인자값으로 매칭이된다.
def file_path_match_module_var(ModuleFileList:list, FileInModuleVar:list):
    MapFileInModuleAbsPath = []     # FileInModule Map Abstact Path
    ResMapFileInModuleAbsPath = []
    TfFilePath = []                 # Check TF File Path
    result = {}
    file_path_dict = {}

    for ModuleFile in ModuleFileList :
        TfFilePath.append(os.path.join(ModuleFile[2], ModuleFile[3]))

    for i in range (0, len(ModuleFileList)):
        AbsModulePath = os.popen("realpath " + ModuleFileList[i][2] + "/" + ModuleFileList[i][0])      # File Path, Module Path
        MapFileInModuleAbsPath.append(AbsModulePath.readline())
    MapFileInModuleAbsPath = list(map(lambda s: s.strip(), MapFileInModuleAbsPath))
    ResMapFileInModuleAbsPath = list(set(MapFileInModuleAbsPath))

    for j in range(0, len(ResMapFileInModuleAbsPath)):
        for i in range(0, len(TfFilePath)):
            if MapFileInModuleAbsPath[i] == ResMapFileInModuleAbsPath[j] :
                if MapFileInModuleAbsPath[i] not in result:
                    result[MapFileInModuleAbsPath[i]] = list()
                file_path_dict = check_duplicate(file_path_dict, TfFilePath[i], { ModuleFileList[i][1]: FileInModuleVar[i]}) #i -> FileInModuleVar[i]
                result[MapFileInModuleAbsPath[i]]=file_path_dict
        file_path_dict = dict()
    return result


def temp_var_assign(ResFileModule:list, ModuleVar:list):
    result = {}
    for i in range(0, len(ModuleVar)):
        result[ModuleVar[i][1]] = ModuleVar[i][0]

    temp = list(ResFileModule.items())
    for i in range(0, len(temp)):
        result[temp[i][0]] = temp[i][1]
    return result

def File_var_match_module_var(ResFileModules:list, ModuleVarLIst:list):
    for ModuleKey, ModuleValue in ResFileModules.items():
        for FileKey, FileValue in ModuleValue.items():
            for Method in range(0, len(FileValue)):
                for Argument, Value in FileValue[Method].items():
                    try:
                        for ModuleVar in ModuleVarList:
                            if ModuleKey  == ModuleVar[0][2]:
                                ResFileModules[ModuleKey][FileKey][Method][Argument] = temp_var_assign(Value, ModuleVar)
                    except:
                        pass
    return ResFileModules