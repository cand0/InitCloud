from ast import Module
import os
import string
import hcl2
import numpy as np
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
        VarPath.append(file_path(TmpModulePathList + " -maxdepth 1 "))              # search current dir
    for TmpVarPath in VarPath:
        VarRes.append(ext_using_method(TmpVarPath, "variable", "default"))
    return VarRes



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
                file_path_dict = check_duplicate(file_path_dict, TfFilePath[i], { ModuleFileList[i][1]: FileInModuleVar[i]})
                result[MapFileInModuleAbsPath[i]]=file_path_dict
        file_path_dict = dict()
    return result
    

if __name__ == "__main__":
    FilePath = file_path('./*')                                                 # Terraform File Path 추출
    ModuleFileList = ext_using_method(FilePath, "module", "source")             # Module 쓰는 파일 및 경로 추출
    ModulePathList = module_path_check(ModuleFileList)                          # 중복된 Module 삭제 및 경로 추출
                                                                                # github, 기타 경로에 없는 module은 No such file or directory로 뜸 + 절대경로로 박혀있는 모듈은 탐색할 수 없음
    ModuleVarList = ext_module_var(ModulePathList)                              # 모듈에서 variable 추출
                                                                                # default가 선언되어있지 않으면 var에 없는걸로 인식함... 그렇게 중요하진 않고 나중에 main 확인하면서 추출된 variable에서 확인 못하면 만드는 로직 추가하면 될듯
                                                                                # ModuleVarList[module dir][method][value]
                                                                                # main에서 위 값 하나씩 가지고 비교를 하면 될듯
    FileInModuleVar = file_in_module_var(ModuleFileList)
    ResFileModule = file_path_match_module_var(ModuleFileList, FileInModuleVar) # 매칭을 위해 아래 두개의 인자값을 가진다.
                                                                                # ModuleFileList    : Module을 사용하는 파일들
                                                                                # FileInModuleVar   : 파일 안에서 모듈에 할당된 것
                                                                                # 매칭을 위해 아래 두개의 인자값을 가진다.
                                                                                # ModuleVarList     : Module에서 변수를 어떠한 형식으로 선언됐는지 확인하기 위한 방법을 위해 type과 변수명

