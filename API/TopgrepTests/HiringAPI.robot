*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    JSONLibrary
# Library    DataDriver    C:/Users/User/OneDrive/Desktop/API_Robot/Testdata/Hiring_login_data.xlsx    sheet_name=Sheet2
# Library    DataDriver    ../Test Data/Hiring_login_data.xlsx   sheet_name=Sheet3

*** Variables ***
${base_url}    https://qa-hiringapi.topgrep.com  
@{qualification}=    Create List   proven experience in designing and executing comprehensive test plans



*** Test Cases ***
TC1_Login_Post Request Demo
# {email: "hiring_robot_auto_test@getnada.com", password: "hiring_robot_auto_test@getnada.coM"} email=hiring_robot_auto_test@getnada.com 

    [Tags]    Post   
    
    # [Template]   ${User_Email}
    Create Session    Session    ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /api/auth
    # ${email}=    Get Value From Data DataDriver    ${User_Email}    ${TEST_NAME}

    ${body}=    Create Dictionary    email=hiring_robot_auto_test@getnada.com     password=hiring_robot_auto_test@getnada.coM
    ${response}=    POST On Session    Session    ${endpoint}    data=${body}
    ${json_response}=    Evaluate    json.loads('''${response.content}''')
    # Log To Console    ${json_response['token']}
    ${token}=    Set Variable    Bearer ${json_response['token']} 
    Set Suite Variable    ${token}    
    Log To Console  ${response.content}
 

    #Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    true

TC2_Login_Get Request Demo
    [Tags]    Get
    Create Session    mysession    ${base_url}
    ${endpoint}    Set Variable    /api/auth   
    ${headers}    Create Dictionary    Authorization    ${token}
    ${response}=    Get On Session    mysession    ${endpoint}    headers=${headers}
    Log To Console    ${response.headers}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${header_value}=    Get From Dictionary    ${response.headers}    Content-Type    Application/Json
    Should Be Equal    ${header_value}    application/json; charset=utf-8


TC3_Jobs_Get Demo
    [Tags]    jobs
    Create Session    mysession    ${base_url}
    ${endpoint}    Set Variable    /api/jobs   
    ${headers}    Create Dictionary    Authorization    ${token}
    ${response}=    Get On Session    mysession    ${endpoint}    headers=${headers}
    # Log To Console    ${response.headers}
    # Log To Console    ${response.status_code}
    Log To Console    ${response.content}
       # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

# TC5_Jobs_Post Demo
#     [Tags]    post a job
#     Create Session    Session   ${base_url}    disable_warnings=1
#     ${endpoint}    Set Variable    /api/jobs
#     ${body}=    Create Dictionary  
#     ...    job_position=test_job
#     ...    descr=awefull
#     ...    qualification=any degree
#     ...    responsibility=none
#     ...    required_skills=[{"id":"V4X7qsY1ZxxNkG2wuYL7Q","tag_name":"API"}]
#     ...    questionnaire=null
#     ...    quiz=null
#     ...    live_assessment=null
#     ...    location=kolkata
#     ...    type=Part-Time
#     ...    experience=[0,3]
#     ${response}=    POST On Session    Session  ${endpoint}    data=${body}


TC4_Jobs_Post Demo
    [Tags]    post_a_job 
    Create Session    Session   ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /api/jobs
    @{qualification_list}=    Create List    proven experience in designing and executing comprehensive test plans
    @{responsibility_list}=    Create List   Develop and maintain software applications 

    ${python}=    Create Dictionary    id=Mm0yDEA__fVs70xaeQEgB    tag_name=Python
    ${API}=    Create Dictionary    id= V4X7qsY1ZxxNkG2wuYL7Q    tag_name= API

    @{required_skills_list}=    Create List    ${python}    ${API}
    @{experience_list}=    Create List    ${1}    ${3}
    &{job_details_dict}=    Create Dictionary    location=kolkata    type=Part-Time    experience=${experience_list}
    @{quiz_data}=    Create List    
    @{live_assesment_data}=    Create List    


    &{body}=    Create Dictionary    job_position=Software Engineer III
    ...    descr=Looking for a skilled software engineer to join our team.
    ...    qualification=${qualification_list}
    ...    responsibility=${responsibility_list}
    ...    required_skills=${required_skills_list}
    ...    questionnaire=${null}
    ...    quiz=${quiz_data}
    ...    live_assessment=${live_assesment_data}
    ...    job_details=${job_details_dict}



    Log To Console    ${body}
    # ${pay_load}=     Convert Json To String    ${body}
    # Log To Console    ${pay_load}
    ${headers}=    Create Dictionary    Authorization    ${token}
    Log To Console    ${headers}
    ${response}=    POST On Session    Session    ${endpoint}    json=${body}    headers=${headers}
    Log To Console   Response Content: ${response.content}
    # ${decoded_content}=    Convert To String    ${response.content}
    # Log To Console    ${decoded_content}
    # ${job_id}=    Get Value From Json    ${decoded_content}    $.data.id
    # Log To Console    this is job id:${job_id}
    ${decoded_content}=    Convert To String    ${response.content}
    # ${response_data}=    Evaluate    json.loads('''${decoded_content}''')    json
    ${response_data}=    Evaluate    json.loads($response.content)    json
    ${job_id}=    Set Variable    ${response_data['data']['id']}
    Set Suite Variable    ${job_id}  
    Log To Console   Job ID: ${job_id}

    # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    kolkata

    # ${response_data}=    Evaluate    json.loads('''${decoded_content}''')    json
    # ${id}=    Get Value From Json    ${response_data}    $.data.id
    # Log To Console    Extracted ID: ${id} 

    # ${data}=    Evaluate    json.loads('''${response.content}''')    json
    # ${id}=    Get Value From Json    ${data}    $.data.id
    # Log    ${id} 
  # ${json_response}=    Evaluate    json.loads('''${response.content}''')
    # Log To Console    ${json_response['id']}
    # ${id}=    Set Variable    ${json_response['id']} 
    # Set Suite Variable    ${id}    
    # Log To Console    ${id}
  

TC5_Delete_The_Job_Posted
    [Tags]    Delete
    Create Session    Session   ${base_url}    disable_warnings=1
    ${endpoint}    Set Variable    /api/jobs/${job_id}
    ${headers}=    Create Dictionary    Authorization    ${token}
    ${response}=    Delete On Session    Session    ${endpoint}    headers=${headers}
    Log To Console     ${response.content}

    # Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    Posting


