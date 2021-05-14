Feature: Testing our demo mock server with a feature that startes the demo mock server in first

  Background:
    * def start = () => karate.start('demo-mock.feature').port
    * def port = callonce start
    * url 'http://localhost:' + port

  Scenario: Test catch all
    * path "does", "not", "exists"
    * method get
    * status 200
    * match response.status == "OK"

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
