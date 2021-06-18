Feature: Test for the home page

  Background: Define URL
    Given url  apiUrl
    * def tokenResponse = callonce read('classpath:src/test/java/com/learn/karate/helpers/CreateToken.feature')
    * def token = tokenResponse.authToken
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
# or function(ms){ } for a no-op !
    * def pause = karate.get('__gatling.pause', sleep)

#  @debug
  Scenario: Create a new article and delete it

#    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article":{"tagList":[],"title":"TestItDe","description":"d","body":"cvcv"}}
    When method Post
    Then status 200
    And match response.article.title == 'TestItDe'
    * def articleId = response.article.slug

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'TestItDe'

    * pause(5000)
#    Given header Authorization = 'Token ' + token
    Given path 'articles',articleId
    When method Delete
    When status 200
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'TestItDe'


