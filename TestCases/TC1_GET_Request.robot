*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${base_url}    https://reqres.in

*** Test Cases ***
Get Request Demo
    Create Session    mysession    ${base_url}
    ${endpoint}    Set Variable    /api/users?page=2
    ${response}=    Get On Session    mysession    ${endpoint}
    Log To Console    ${response.headers}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    
     # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    
    # Validations
    # ${status_code}=    Convert To String    ${response.status_code}
    # Should Be Equal    ${status_code}    200

    # ${json_response}=    Convert

    # ${header_value}=    Get From Dictionary    ${response.headers}    Content-Type
    # Should Be Equal    ${header_value}    application/json; charset=utf-8