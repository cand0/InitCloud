# BoB InitCloud Project
<table>
<tr>
    <td>기간</td>
    <td>22.08.26 - 22.12.17</td>
</tr>
<tr>
    <td>목적</td>
    <td>IaC(Terraform)에서발생할 수 있는 보안 위협을 연구하며 사용자에게 이해하기 쉬운 형태로 전달한다. </td>
</tr>
<tr>
    <td>역할</td>
    <td>PM/Rule 연구</td>
</tr>
</table>
<hr />

<pre>
.
tree
├── aws
│   ├── etc
│   │   ├── test
│   │   │   ├── EC2
│   │   │   └── IAM
│   │   ├── testcode
│   │   │   ├── test_count
│   │   │   ├── test_data
│   │   │   ├── test_error
│   │   │   ├── test_module
│   │   │   └── vpc_module
│   │   └── visualization
│   └── study
│       ├── Rule
│       │   ├── EBS
│       │   ├── EC2
│       │   ├── IAM
│       │   ├── Module
│       │   ├── S3
│       │   └── VPC
│       ├── etc
│       │   ├── CheckOVModuleValidationCheck
│       │   └── SG&NACL consistent settings
│       └── module_scan
│           ├── DiffArg
│           └── testcode_module
├── module
│   ├── sg
│   └── vpc_module
└── ncp
    ├── Rule
    └── sample
</pre>

<table>
<tr>
    <td>dir :: study</td>
    <td>연구 자료</td>
</tr>
<tr>
    <td>dir :: module</td>
    <td>rule 연구를 하며 필요한 module 제작</td>
</tr>
<tr>
    <td>dir :: module_scan</td>
    <td>파싱 + 일관성 없는 모듈 스캔 -> 모듈 시각화&보안 위협 탐지</td>
</tr>
