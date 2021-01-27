Feature: New Karate 1.0 Features in Action

Scenario: Html Templateing
    Given url 'https://jsonplaceholder.typicode.com'
    * path 'users'
    When method get
    Then status 200
    * def users = response
    * doc {read : 'users.html'}


  Scenario: Pretty Printed Matcher
  * def actual = {a: 1, b: 2, c : {c1: 1, c2: 2}}
  * match actual == {a: 1, b: 2, c : {c1: 1, c2: 3}}

  Scenario: Matcher pretty, contains used wrongly
  * def actual =
  """
{
  "id": 1,
  "email": "Sincere@april.biz",
  "username": "Bret",
  "company": {
    "bs": "harness real-time e-markets",
    "catchPhrase": "Multi-layered client-server neural-net",
    "name": "Romaguera-Crona"
  }
}    
  """
    * match actual contains {company : {name : "Romaguera-Crona"}}


  Scenario: Matcher pretty, type dosen't match
  * def actual =
  """
{
  "id": 1,
  "email": "Sincere@april.biz",
  "username": "Bret",
  "company": {
    "bs": "harness real-time e-markets",
    "catchPhrase": "Multi-layered client-server neural-net",
    "name": "Romaguera-Crona"
  }
}    
  """
    * match actual contains {id :"1"}


    Scenario:  ES6 Support
    * def myLog = x =>  karate.log(x)}
    * myLog("test")

    Scenario:  ES6 Support
    * def log = x =>  karate.log(`${new Dat()}: ${x}`)
    * log("test")


    Scenario Outline: Js Function in Data Driven Test Case: Creating User <email>
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": #(email),
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    Examples:
    | i => i > 2 ? null : ({email: `test_${i}@user.com`}) | 
