Feature: stateful mock server

  Background:
    * def curId = 0
    * def nextId = function(){ return ~~curId++ }
    * def cats = {}

Scenario: pathMatches('/greeting') && paramExists('name')
    * def content = 'Hello ' + paramValue('name') + '!'
    * def response = { id: '#(nextId())', content: '#(content)' }

  Scenario: pathMatches('/greeting')
    * def response = { id: '#(nextId())', content: 'Hello World!' }

  Scenario: pathMatches('/cats') && methodIs('post') && typeContains('xml')
    * def cat = request
    * def id = nextId()
    * set cat /cat/id = id
    * set catJson
      | path | value        |
      | id   | id           |
      | name | cat.cat.name |
    * cats[id + ''] = catJson
    * def response = cat

  Scenario: pathMatches('/cats') && methodIs('post')
    * def cat = request
    * def id = nextId()
    * set cat.id = id
    * cats[id + ''] = cat
    * def response = cat

  Scenario: pathMatches('/cats')
    * def response = $cats.*

  Scenario: pathMatches('/cats/{id}') && methodIs('put')
    * def cat = request
    * def id = pathParams.id
    * cats[id + ''] = cat
    * def response = cat

  Scenario: pathMatches('/cats/{id}')
    * def response = cats[pathParams.id]

  Scenario: pathMatches('/cats/{id}/kittens')
    * def response = cats[pathParams.id].kittens

# This a catch all scenario handles every request, that hasn't been handled before.
  Scenario:
    * print 'No dedicated scenario matches incoming request.'
    * print `Request: ${requestMethod}:${requestUrlBase}/${requestUri}`
    * print `Request Body: ${request}`
    * def responseStatus = 200
    * def response = {status:'OK'}
