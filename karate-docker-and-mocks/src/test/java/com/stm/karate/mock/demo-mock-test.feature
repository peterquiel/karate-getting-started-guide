Feature: Testing our demo mock server

  Background:
    * match karate.properties['mock_server_port'] == '#string'
    * def mockUrl = `http://localhost:${karate.properties['mock_server_port']}`
    * print `Mock server url is ${mockUrl}`
    * url mockUrl

  Scenario: Test greeting endpoint
    * path 'greeting'
    * method get
    * status 200
    * match response == { id: "#number", content: "Hello World!"}

  Scenario: Test greeting endpoint with parameter
    * path 'greeting'
    * param name = "Peter"
    * method get
    * status 200
    * match response == { id: "#number", content: "Hello Peter!"}
