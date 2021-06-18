@debugs
Feature: Test for the home page

  Background: Define URL
    Given url  apiUrl

  Scenario: Get all the tags and assert
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['test']
    And match response.tags !contains ['truck']
    And match response.tags contains any ['fish','dog','SIDA']
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get 10 articles and assert and validate schema
    * def timeValidator = read('com/vocalink/pr/helpers/timeValidator.js')

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 500
    And match response == {"articles": #array, "articlesCount": 500}
    And match response.articles[0].createdAt contains '2021'
    And match response.articles[*].favoritesCount contains 1
    And match response..favoritesCount == '#array'
    And match response..bio contains null
    And match response..bio == '#array'
    And match each response..following == '#boolean'
    And match response == {"articles": #array, "articlesCount": 500}
    And match each response..bio == '##string'
    And match each response.articles ==
    """
    {
      "title": "#string",
      "slug": "#string",
      "body": "#string",
      "createdAt": "#? timeValidator(_)",
      "updatedAt": "#? timeValidator(_)",
      "tagList": [ ],
      "description": "#string",
      "author": {
        "username": "#string",
        "bio": null,
        "image": "#string",
        "following": '#boolean'
      },
      "favorited": '#boolean',
      "favoritesCount": '#number'
    }
    """

  Scenario: Conditional Logic
    Given params {limit:10 ,offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]
    * def result = favoritesCount == 0 ? karate.call('classpath:src/test/java/com/vocalink/pr/helpers/addlikes.feature',article).likesCount : favoritesCount

    Given params {limit:10 ,offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == 1

  @retry
  Scenario: Retry call
    * configure retry = {count: 10, interval: 5000}
    Given params {limit:10 ,offset:0}
    Given path 'articles'
#    And retry until response.articles[0].favoritesCount == 20
    When method Get
    Then status 200

  @sleep
  Scenario: Retry call
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given params {limit:10 ,offset:0}
    Given path 'articles'
#    And retry until response.articles[0].favoritesCount == 20
    When method Get
    * eval sleep(5000)
    Then status 200