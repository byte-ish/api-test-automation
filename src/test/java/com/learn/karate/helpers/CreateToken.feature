Feature: Create Token

  Scenario:
    Given url  apiUrl
    Given path 'users/login'
    And request {"user":{"email":"#(userEmail)","password":"#(userPass)"}}
    When method Post
    Then status 200
    * def authToken = response.user.token