*** Settings ***
Library    Collections
Library    String
# Library    JsonLibrary
Library    RequestsLibrary

*** Variables ***

${base_url}    https://reqres.in

*** Test Cases ***
Get Request Demo
    [Tags]    Demo
    Create Session    Session1    ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users?page=2
    ${response}    GET On Session    Session1    ${endpoint}
    Log To Console    ${response.headers}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    
    # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    # ${json_response}=    Convert

    ${header_value}=    Get From Dictionary    ${response.headers}    Content-Type    Application/Json
    Should Be Equal    ${header_value}    application/json; charset=utf-8