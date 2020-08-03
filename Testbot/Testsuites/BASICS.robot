*** Settings ***
Suite Setup       Suite-Setup
Suite Teardown    Suite-Teardown
Library           Collections
Library           OperatingSystem
Library           String
Resource          ../Libraries/BASICS-lib.txt

*** Variables ***
${num1}           28

*** Test Cases ***
TC001 Intro to Keywords
    [Setup]    Test-Setup-1
    ${sum}    Add-Integers    ${num1}    22
    Should Be Equal    ${sum}    ${50}
    [Teardown]    Test-Teardown-1

TC002 Variable Scope
    [Setup]    Test-Setup-2
    Vaiable-Scope
    Set-Variable-Scope
    Run Keyword if    ${testvariable} == ${val1}    Log    Test variable
    ...    ELSE    Log    Variable not found
    ${i}    Set Variable    ${1}
    FOR    ${Iter}    IN    @{List-Names}
        ${RES}    Catenate    SEPARATOR=-    ${Iter}    ${i}
        ${i}    Add-Integers    ${i}    1
        Log    ${RES}
    END
    ${i}    Set Variable    ${1}
    ${MyDictionary}    Create Dictionary    Names=Thiru    Place=Warangal    Subject=EBS    College=Amrita    Dept=EEE
    ${MyList1}    Get Dictionary Keys    ${MyDictionary}
    FOR    ${Iter}    IN    @{Mylist1}
        Run Keyword if    '${Iter}' == 'Names'    Remove From Dictionary    ${MyDictionary}    Names
        Run Keyword if    '${Iter}' == 'College'    Exit For Loop
    END
    Create File    D:/Nokia/Libraries/Common-lib.txt    Hello, World!
    File Should Exist    D:/Nokia/Libraries/Common-lib.txt
    Count Files In Directory    D:/Nokia/Libraries
    Append To File    D:/Nokia/Libraries/Common-lib.txt    \nThis is Robot-Framework
    ${FileC}    Get File    D:/Nokia/Libraries/Common-lib.txt
    Move File    D:/Nokia/Libraries/Common-lib.txt    D:/Nokia/Testsuites
    File Should Exist    D:/Nokia/Testsuites/Common-lib.txt
    Remove File    D:/Nokia/Testsuites/Common-lib.txt
    File Should Not Exist    D:/Nokia/Testsuites/Common-lib.txt
    Create File    D:/Nokia/Libraries/Test-lib.txt    A AN. or Ask. the and\nor the\nor the\nand
    ${FileC}    Get File    D:/Nokia/Libraries/Test-lib.txt
    ${FileC}    Get Lines Containing String    ${FileC}    the
    ${FileC}    GetLines Matching Pattern    ${FileC}    A*
    ${FileC}    Convert To Lower Case    ${FileC}
    ${FileC}    Remove String    ${FileC}    or
    ${FileC}    Replace String    ${FileC}    and    or
    Remove File    D:/Nokia/Libraries/Test-lib.txt
    [Teardown]    Test-Teardown-2

TC003 Lists and Dictionary
    ${List-Copy}    Copy List    ${List-Names}
    Insert Into List    ${List-Copy}    2    SQL
    Remove Values From List    ${List-Copy}    Robot
    Remove From List    ${List-Copy}    3
    Get Length    ${List-Copy}
    Run Keyword and Ignore Error    List Should Contain Sub List    ${List-Names}    ${List-Copy}    msg=Not a sub List    values=False
    Log    ${List-Copy}
    ${matches}    Get Matches    ${List-Copy}    P*
    Get Length    ${matches}
    ${MyDictionary}    Create Dictionary    Names=Thiru    Place=Warangal    Subject=EBS    College=Amrita    Dept=EEE
    ${MyList1}    Get Dictionary Keys    ${MyDictionary}
    ${MyList2}    Get Dictionary Values    ${MyDictionary}
    ${Collage}    Get From Dictionary    ${MyDictionary}    College
    Remove From Dictionary    ${MyDictionary}    Subject
    Set To Dictionary    ${MyDictionary}    Class=Nokia
    Log    ${MyDictionary}
