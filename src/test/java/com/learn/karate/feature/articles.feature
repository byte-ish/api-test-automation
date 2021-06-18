@article
@parallel=false
Feature: Test for the home page

  Background: Define URL
    Given url  apiUrl
   * def tokenResponse = callonce read('classpath:com/learn/karate/helpers/CreateToken.feature')
    * def token = tokenResponse.authToken
    * def articlesRequestBody = read('classpath:src/test/resources/json/newArticleRequest.json')
    * print articlesRequestBody
    * def dataGenerator = Java.type('com.learn.karate.helpers.DataGenerator')
    * set articlesRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articlesRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articlesRequestBody.article.body = dataGenerator.getRandomArticleValues().body

  Scenario: Create a new article

    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request articlesRequestBody
    When method Post
    Then status 200
    And match response.article.title == articlesRequestBody.article.title

  Scenario: Create a new article and delete it
    Given path 'articles'
    And request articlesRequestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

    # Verify the article exists
    Given params {limit: 30, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == articlesRequestBody.article.title

    #Delete that article
    Given path 'articles',articleId
    When method Delete
    When status 200

    #Verify article deleted
    Given params {limit: 30, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != articlesRequestBody.article.title


