Feature: Testing File Server Mock

  Background:
    * def startMockServer = () => karate.start('FileServerMock.feature').port
    * def port = callonce startMockServer
    * url 'http://localhost:' + port
  
  Scenario: Post a new file and get it file meta data
    Given path 'files'
    * def expectedFileContent = "Content of our test file."
    * multipart file file =  {value: #(expectedFileContent), filename: "test.txt", contentType: 'text/plain' }
    When method post
    Then status 200
    * match response == {id:"#number", name : "test.txt", content: "#string", contentType: "text/plain"}
  
  
    * def decode = (base64Str) => {return new java.lang.String(java.util.Base64.getDecoder().decode(base64Str))}
    * def content = decode(response.content)
    * match content == expectedFileContent

    * def fileId = response.id
    Given path 'files', fileId
    When method get
    Then status 200
    * match response == {id:"#number", name : "test.txt", content: "#string", contentType: "text/plain"}
    * def content = decode(response.content)
    * match content == expectedFileContent
    
  Scenario: Post a new file and get binary content 
    Given path 'files'
    * def expectedFileContent = "Content of our test file."
    * multipart file file =  {value: #(expectedFileContent), filename: "test.txt", contentType: 'text/plain' }
    When method post
    Then status 200

    * def fileId = response.id
    Given path 'files', fileId, 'content'
    When method get
    Then status 200
    * match header content-type == 'text/plain'
    * match response == expectedFileContent

  Scenario: Testing Catch All Rule
    Given path "path", "does", "not", "exist"
    * param url = "parameter"
    * request {request:"content"}
    When method put
    Then status 200
    * match response.status == "catch all"