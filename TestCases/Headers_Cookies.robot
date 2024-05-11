*** Settings ***
Library    Collections
Library    String
# Library    JsonLibrary
Library    RequestsLibrary

*** Variables ***

${base_url}    http://jsonplaceholder.typicode.com

*** Test Cases ***
 Test Headers Demo
    [Tags]    Demo
    Create Session    Session1    ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /photos
    ${response}    GET On Session    Session1    ${endpoint}
    # Log To Console    ${response.headers}

    ${ContentTypevalue}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${ContentTypevalue}    application/json; charset=utf-8
    ${ContentEncodevalue}=    Get From Dictionary    ${response.headers}    Content-Encoding
    Should Be Equal    ${ContentEncodevalue}    gzip

Test Cookies Demo
    [Tags]    Demo
    Create Session    Session1    ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /photos
    ${response}    GET On Session    Session1    ${endpoint}
    # Log To Console    ${response.cookies}  # Displays all cookies from response

    ${cookievalue}=    Get From Dictionary    ${response.cookies}   dhhfds34erds    
    Log To Console    ${cookievalue}  # Display specific cookie value
 