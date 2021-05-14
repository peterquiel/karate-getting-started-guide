Feature: stateful mock server

  Background:
    * def curId = 0
    * def nextId = function(){ return ~~curId++ }

Scenario: pathMatches('/greeting') && paramExists('name')
    * def content = 'Hello ' + paramValue('name') + '!'
    * def response = { id: '#(nextId())', content: '#(content)' }

  Scenario: pathMatches('/greeting')
    * def response = { id: '#(nextId())', content: 'Hello World!' }

# This a catch all scenario handles every request, that hasn't been handled before.
  Scenario:
    * print 'No dedicated scenario matches incoming request.'
    * print 'With Headers:'
    * print requestHeaders
    * print 'With Request Parameters'
    * print requestParams
    * print 'And Request:'
    * print request
    * def responseStatus = 200
    * def response = {status:'OK'}
