*** Settings ***
Library    Collections
Library    String
# Library    JsonLibrary
Library    RequestsLibrary

*** Variables ***

${base_url}    https://reqres.in

*** Test Cases ***
Post Request Demo
    [Tags]    Demo
    Create Session    Session1    ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /api/users
    ${body}=    Create Dictionary    name=Rohit    job=SW Engineer
    ${response}=    POST On Session    Session1    ${endpoint}    data=${body}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    #Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201

    # ${json_response}=    Convert String to json    ${response.content}
    # ${contents}=    Get Value From Json    ${json_response}    ${id_path}
    # Should Not Be Empty    ${contents}
