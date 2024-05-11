*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${base_url}    https://gorest.co.in
${bearer_token}    Bearer a5d423e38baa1513c2f8ffa6b82708eb96905de34ba096a151d951beadd3b02e
${Content_type}    application/json

*** Test Cases ***
# Get Request Demo
#     Create Session    mysession    ${base_url}
#     ${endpoint}    Set Variable    /api/users?page=2
#     ${response}=    Get On Session    mysession    ${endpoint}
#     Log To Console    ${response.headers}
#     Log To Console    ${response.status_code}
#     Log To Console    ${response.content}


Get Request Demo
    Create Session    mysession    ${base_url}
    ${headers}    Create Dictionary    Authorization=${bearer_token}    Content-Type=${Content_type}

    ${response}=    GET On Session    mysession    /users/3021
