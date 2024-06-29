*** Settings ***
Library   Browser
Library    String

#Library    RPA.Browser.Selenium
#Library    RPA.Windows
#Library    RPA.Browser.Selenium

*** Variables ***
${browser}    chromium
${url}    https://www.multitude.com/careers
@{Job Role}    Software Test Engineer
##${url1}    https://multitude.bamboohr.com/careers
    

*** Test Cases ***
RoleSearch Test
    New browser    browser=${browser}     headless=${False}    args=["--start-maximized"]
    New Context    viewport=${None} 
    New Page  url=${url} 
    
     Click    xpath=//button[@id='cc-acceptAll-btn']
     #Click    span >> Accept all
     #${current page}=    Switch PAGE    New
     #Get Page Ids    ACTIVE    ACTIVE    ACTIVE
     Click    xpath=//a[@class='icon-primart-cta primary-cta']
     
     #Scroll By    ${None}    300    0    auto
     #Click    xpath=//h2[@class='MuiTypography-root MuiTypography-h2 jss-f69 fabric-1x6asz-h2-root css-osj07k']
     ##Go Forward
    #  ${previous_page}=    Switch PAGE    New
    #  Switch Page    ${previous_page}
    #  Close Page    ${previous_page}
    #${state_file} =    Save Storage State
    #  Create new context with saved state
    #New context    storageState=${state_file}
    Switch Page    NEW
    #Close Page
    #New Page    https://multitude.bamboohr.com/careers
     Scroll To Element    xpath=//div[37]//li[1]//div[1]//a[1]
     Click    xpath=//div[37]//li[1]//div[1]//a[1]  
    
    #Click    text=.class>icon-primart-cta primary-cta
    Sleep    5  
    Take Screenshot    Carrerpage.png    
    Scroll By    ${None}    600    0    auto
    Take Screenshot    Carrerpage1.png 
    Scroll To    ${None}    bottom    left    auto
    Take Screenshot    Carrerpage2.png
    ${current url}    Get Url 
    Close Browser
    Should Contain Any    ${current url}    @{Job Role}        
     

     
    