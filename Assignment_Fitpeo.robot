*** Comments ***
1. Prerequisites
Ensure the following prerequisites are met before setting up the environment:

Python (version 3.7 or above): Download and install from python.org.
Google Chrome: The script is set to run in Chrome, so ensure it’s installed.
ChromeDriver: Compatible with your installed Chrome version. You can download it from chromedriver.chromium.org.

2. Environment Setup
Step 1: Install Python Packages
Open a terminal (or command prompt).

Install Robot Framework and necessary libraries by running the following command:

    pip install robotframework 
    robotframework-seleniumlibrary
    robotframework-rpaframework
robotframework is the core framework.
robotframework-seleniumlibrary provides support for browser automation.
robotframework-rpaframework includes RPA capabilities, although desktop automation is not used here.

Step 2: Install and Configure ChromeDriver
Download ChromeDriver that matches your installed Chrome version.
Place chromedriver.exe (or the equivalent for your OS) in a folder included in your system’s PATH, or specify its path directly in the script.

Step 3: Verify Installation
Run the following commands in the terminal to ensure that the packages are installed correctly:

robot --version
pip show robotframework-seleniumlibrary
pip show robotframework-rpaframework

Each command should confirm the version if installation was successful.

3. Running the Script
Save the Script: Create a file, such as filename.robot, and paste the script content into this file.

Run the Script:

Open a terminal in the directory where the .robot file is located.
Execute the script with the following command:

robot filename.robot
View the Results:

After the script completes, Robot Framework will generate log.html, report.html, and output.xml files in the same directory.
Open report.html in a web browser to view the test results.

*** Settings ***
Library    SeleniumLibrary
Library    RPA.Desktop

*** Variables ***
${URL}    https://www.fitpeo.com/home
${BROWSER}    chrome
${Revenue Calculator}    //div[contains(text(),'Revenue Calculator')]
${SLIDER_LOCATOR}    //input[@type='range']
${SLIDER_THUMB}    //span[@class="MuiSlider-thumb MuiSlider-thumbSizeMedium MuiSlider-thumbColorPrimary MuiSlider-thumb MuiSlider-thumbSizeMedium MuiSlider-thumbColorPrimary css-1sfugkh"]
${NUMBER_INPUT}    //input[@type='number']
${CHECKBOX_1}    (//input[@type='checkbox'])[1]
${CHECKBOX_2}    (//input[@type='checkbox'])[2]
${CHECKBOX_3}    (//input[@type='checkbox'])[3]
${CHECKBOX_8}    (//input[@type='checkbox'])[8]
${TOTAL_RECURRING_REIMBURSEMENT_TEXT}    Total Recurring Reimbursement for all Patients Per Month:
${CALCULATED_TAB}    (//p[@class='MuiTypography-root MuiTypography-body2 inter css-1xroguk'])[4]
${CALCULATED_VALUE}    (//p[@class='MuiTypography-root MuiTypography-body1 inter css-1bl0tdj'])[4]

*** Test Cases ***
Test To Verify Navigation
    Verify Navigation 
    Verify Navigate to the Revenue Calculator Page And Set Values
    Verify Selecting The Checkboxes
    Verify Validate Total Recurring Reimbursement

*** Keywords ***
Verify Navigation 
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Page Should Contain    FitPeo

Verify Navigate to the Revenue Calculator Page And Set Values
    Click Element    ${Revenue Calculator}
    Sleep    2s
    Scroll Element Into View    //p[text()='CPT-99091']
    ${input_value}    Get Value    ${NUMBER_INPUT}
    # Adjust the slider by offset
    Drag And Drop By Offset    ${SLIDER_THUMB}    94    40
    Sleep    2s
    Page Should Contain Element    ${NUMBER_INPUT}
    # Verify the value in the input field after sliding
    # Clear and reset slider value
    Clear Element Text    ${NUMBER_INPUT}
    Sleep    2s
    Drag And Drop By Offset    ${SLIDER_THUMB}    -39    40
    Sleep    2s

Verify Selecting The Checkboxes
    Scroll Element Into View    ${CHECKBOX_1}
    Wait Until Element Contains    //p[text()='CPT-99091']   CPT-99091
    Click Element    ${CHECKBOX_1}
    Click Element    ${CHECKBOX_2}
    Click Element    ${CHECKBOX_3}
    Scroll Element Into View    ${CHECKBOX_8}
    Click Element    ${CHECKBOX_8}

Verify Validate Total Recurring Reimbursement
    Page Should Contain Element    ${CALCULATED_TAB}
    ${calculated_value}    Get Text    ${CALCULATED_VALUE}
    Page Should Contain    ${TOTAL_RECURRING_REIMBURSEMENT_TEXT}
    Page Should Contain    ${calculated_value}
