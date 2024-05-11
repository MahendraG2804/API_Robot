*** Settings ***
Library    Collections
Library    String
# Library    JsonLibrary
Library    RequestsLibrary

*** Variables ***

${base_url}    https://reqres.in

*** Test Cases ***
Put Request Demo
    [Tags]    Demo
    Create Session    Session1    ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users/2
    ${body}=    Create Dictionary    name=Virat    job=Cricketer
    ${response}=    PUT On Session    Session1    ${endpoint}    data=${body}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    #Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    # ${json_response}=    Convert String to json    ${response.content}
    # ${contents}=    Get Value From Json    ${json_response}    ${id_path}
    # Should Not Be Empty    ${contents}
