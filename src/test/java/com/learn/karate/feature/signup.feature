@signup
Feature: Sign Up New User

  Background: Preconditions
    * def dataGenerator = Java.type('com.learn.karate.helpers.DataGenerator')
    Given url apiUrl


  Scenario: New user signup
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    * print randomEmail
    * print randomUsername
    Given path 'users'
    And request
    """
      {
      "user": {
      "email": #(randomEmail),
      "password": "asdasdasdasdasd",
      "username": #(randomUsername)
      }
      }
    """
    And method Post
    Then status 200


  @error
  Scenario Outline: Validate Signup error messages
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()

    Given path 'users'
    And request
    """
      {
      "user": {
      "email": '<email>',
      "password": "<password>",
      "username": '<username>'
      }
      }
    """
    And method Post
    Then status <statusCode>
    And match response == <errorResponse>
    Examples:
      | email          | password  | username          | errorResponse                                      | statusCode |
      | #(randomEmail) | karat@123 | KarateUser123     | {"errors":{"username":["has already been taken"]}} | 422        |
      | ish@ish.com    | karat@123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    | 422        |



