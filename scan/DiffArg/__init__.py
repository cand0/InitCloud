import TfFile               # All Tf File
import TfModuleFile         # Module using TfFile
import Module               # Module File
import Merge             # TfModuleFile & Module File Merge
import Check             # Check The Difference

class __init__ :

    def DiffArg():
        FilePath = TfFile.file_path('./*')                                                      # Terraform File Path 추출

        ModuleFileList = TfModuleFile.ext_using_method(FilePath, "module", "source")            # Module 쓰는 파일 및 경로 추출
        ModulePathList = TfModuleFile.module_path_check(ModuleFileList)                         # 중복된 Module 삭제 및 경로 추출
        FileInModuleVar = TfModuleFile.file_in_module_var(ModuleFileList)
                                                                                                # github, 기타 경로에 없는 module은 No such file or directory로 뜸 + 절대경로로 박혀있는 모듈은 탐색할 수 없음
        ModuleVarList = Module.ext_module_var(ModulePathList)                                   # 모듈에서 variable 추출
                                                                                                # default가 선언되어있지 않으면 var에 없는걸로 인식함... 그렇게 중요하진 않고 나중에 main 확인하면서 추출된 variable에서 확인 못하면 만드는 로직 추가하면 될듯
                                                                                                # ModuleVarList[module dir][method][value]
                                                                                                # main에서 위 값 하나씩 가지고 비교를 하면 될듯
        ResFileModules = Merge.file_path_match_module_var(ModuleFileList, FileInModuleVar)      # 매칭을 위해 아래 두개의 인자값을 가진다.
                                                                                                # ModuleFileList    : Module을 사용하는 파일들
                                                                                                # FileInModuleVar   : 파일 안에서 모듈에 할당된 것
                                                                                                # 매칭을 위해 아래 두개의 인자값을 가진다.
                                                                                                # ModuleVarList     : Module에서 변수를 어떠한 형식으로 선언됐는지 확인하기 위한 방법을 위해 type과 변수명
        VarResult = Merge.File_var_match_module_var(ResFileModules, ModuleVarList)              # 파일 변수 선언과 모듈 default를 매칭해준다.
        DiffArg = Check.file_diff_in_module(VarResult)                                          # 루트모듈 안에 다른 파일과 다른 부분의 argument만 추출
        return DiffArg
    DiffArg()
