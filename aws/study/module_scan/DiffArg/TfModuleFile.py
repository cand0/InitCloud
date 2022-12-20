from ast import Module
import os
import string
import hcl2
import dictdiffer
import pprint

'''
current dir -> find module file path
return value list   
    ex) [[modulePath, ModuleName, Keys, FilePath, FileName] ...]
        [['../..', 'custom-terraform-aws-vpc', 'vpc1', '.', 'cand1.tf'], ['../..', 'custom-terraform-aws-vpc', 'vpc2', '.', 'cand1.tf',], ['../..', 'custom-terraform-aws-vpc', 'vpc', '.', 'cand2.tf'] ... ]
'''
def ext_using_method(path:list, method:string, argument:string):
    ExtFileMethods = []
    for file in path:
        with open(file, 'r', encoding="utf-8") as fd:
            dict = hcl2.load(fd)
        try:                                                            # Exception handling when Argument does not exist
            ExtArgs = dict.get(method)
            for ExtArg in ExtArgs:
                if argument == list(ExtArg.keys())[0]:                  # Module Ext Keys to ext_module_var
                    return list(ExtArg.values())
                ResValue = list(ExtArg.values())[0][argument]
                Keys = list(ExtArg.keys())[0]
                FilePath, FileName = os.path.split(file)
                ExtFileMethods.append([ResValue, Keys, FilePath, FileName])
        except:
            pass
    return ExtFileMethods


    '''
absolute path to module
return value list   
    ex) [[ModulePath1, ModulePath2 ...]
        ['/InitCloud/scan/custom-terraform-aws-vpc', '/custom-terraform-aws-vpc']
'''
def module_path_check(ModuleFileList:list):
    ModuleList = []
    # print(ModuleFileList[8]) -> terraform/aws ... <- 경로가 아닌 그냥 스태틱하게 박혀있어서 No such File or Dir 뜸 (아래 os.popen 에서)
    for i in range (0, len(ModuleFileList)):
        AbsModulePath = os.popen("realpath " + ModuleFileList[i][2] + "/" + ModuleFileList[i][0])      # File Path, Module Path
        ModuleList.append(AbsModulePath.readline())
    ModuleList = list(map(lambda s: s.strip(), ModuleList))
    try:                                          # Blank Delete
        ModuleList.remove('')
    except:
        pass

    return list(set(ModuleList))


def ext_Module_Arg(path:list, method:string, argument:string):
    for file in path:
        with open(file, 'r', encoding="utf-8") as TmpFile:
            dict = hcl2.load(TmpFile)
        try:                                                            # Exception handling when module does not exist
            ModuleFiles = dict.get(method)
            for ModuleFile in ModuleFiles:
                if argument == list(ModuleFile.keys())[0]:
                    return list(ModuleFile.values())
        except :
            pass

def file_in_module_var(ModuleFileList:list):
    CheckFilePath = []              # Check the analysis file location // File relative address
    FileInModuleVar = []

    for ModuleFile in ModuleFileList:
        CheckFilePath.append(ModuleFile[2] + "/" + ModuleFile[3])

    for i in range (0, len(ModuleFileList)):
        FileInModule = ext_Module_Arg([CheckFilePath[i]], "module", ModuleFileList[i][1])     # module name ex) vpc1, vpc2, vcp3 ...
        for TmpFileInModule in FileInModule :
            FileInModuleVar.append(TmpFileInModule)

    return FileInModuleVar

    