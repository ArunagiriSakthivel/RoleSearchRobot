*** Settings ***
# Import use Browser Library
Library     Browser
Library     ExcelLibrary


*** Variables ***
# Set up browser,URL and search criteria.Here its hard coded, we can use excel Library for multi test data
${browser}      ${None}
${url}          ${None}
${Job Role}     ${None}
${FilePath}     ./TestData/InputTestData.xlsx
${current url}  ${None}


*** Test Cases ***
# Validate search criteria testcases
RoleSearch Test
    ${browser}    Read Excel    ${FilePath}    Data    2    1    # Read Browser column value from Excel
    ${url}    Read Excel    ${FilePath}    Data    2    2    # Read URL column value from Excel
    ${Job Role}    Read Excel    ${FilePath}    Data    2    3    # Read Role Position column value from Excel
    New browser    browser=${browser}    headless=${False}    args=["--start-maximized"]
    New Context    viewport=${None}
    New Page    url=${url}
    Click    xpath=//button[@id='cc-acceptAll-btn']    # Accept Cookies button locator
    Click    xpath=//a[@class='icon-primart-cta primary-cta']    # Search button locator
    Switch Page    NEW
    Scroll To Element    xpath=//div[37]//li[1]//div[1]//a[1]    # Scroll to Role link
    Click    xpath=//div[37]//li[1]//div[1]//a[1]
    # Smart wait for condition of element visible
    Wait For Elements State
    ...    xpath=//div[contains(@class,'fab-Card fab-Card--sizeFull fab-Card--withoutBottomGradient')]//span[@class='jss-f156'][normalize-space()='Apply for This Job']
    ...    visible
    Take Screenshot    Carrerpage.png    # Role Page screenshot
    Scroll By    ${None}    600    0    auto
    Take Screenshot    Carrerpage1.png
    Scroll To    ${None}    bottom    left    auto
    Take Screenshot    Carrerpage2.png
    ${current url}    Get Url
    Close Browser
    IF    "${Job Role}" != "${current url}"            # Write Reuslt in Excel Document
        Write Excel Fail
    ELSE
        Write Excel Pass
    END
    Should Contain Any    ${current url}    ${Job Role}            # Validate Role link and browser URL comparision


*** Keywords ***
Read Excel    # Read Excel file data
    [Arguments]    ${FilePath}    ${sheetname}    ${rownum}    ${colnum}
    Open Excel Document    ${FilePath}    1
    Get sheet    ${sheetname}
    ${data}    Read Excel Cell    ${rownum}    ${colnum}
    Close Current Excel Document
    RETURN    ${data}

Write Excel Pass    # Write excel data for Pass condition
    Open Excel Document    ${FilePath}    1
    Write Excel Cell    2    4    PASS
    Write Excel Cell    2    5    Link for Job Position Software Test Engineer present in WEB URL
    Save Excel Document    ${FilePath}
    Close Current Excel Document

Write Excel Fail    # Write excel data for Fail condition
    Open Excel Document    ${FilePath}    1
    Write Excel Cell    2    4    FAIL
    Write Excel Cell    2    5    Link for Job Position Software Test Engineer not present in WEB URL
    Save Excel Document    ${FilePath}
    Close Current Excel Document
