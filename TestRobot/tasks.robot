*** Settings ***
# Import use Browser Library
Library     Browser


*** Variables ***
# Set up browser,URL and search criteria.Here its hard coded, we can use excel Library for multi test data
${browser}      chromium
${url}          https://www.multitude.com/careers
@{Job Role}     Software Test Engineer


*** Test Cases ***
# Validate search criteria testcases
RoleSearch Test
    New browser    browser=${browser}    headless=${False}    args=["--start-maximized"]
    New Context    viewport=${None}
    New Page    url=${url}
    Click    xpath=//button[@id='cc-acceptAll-btn']            #Accept Cookies button locator
    Click    xpath=//a[@class='icon-primart-cta primary-cta']  #Search button locator  
    Switch Page    NEW   
    Scroll To Element    xpath=//div[37]//li[1]//div[1]//a[1]  #Scroll to Role link  
    Click    xpath=//div[37]//li[1]//div[1]//a[1]   
    Sleep    5
    Take Screenshot    Carrerpage.png                          #Role Page screenshot
    Scroll By    ${None}    600    0    auto
    Take Screenshot    Carrerpage1.png
    Scroll To    ${None}    bottom    left    auto
    Take Screenshot    Carrerpage2.png
    ${current url}    Get Url
    Close Browser
    Should Contain Any    ${current url}    @{Job Role}        #Validate Role link and browser URL comparision
