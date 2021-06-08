Feature: Mock for File Store Api

  Background:
    * def files = {}
    * def idSequence = 1
    * def nextId = () => { return idSequence++}
    * def encode = (byteArray) => {return java.util.Base64.getEncoder().encodeToString(byteArray)}
    * def decode = (base64Str) => {return java.util.Base64.getDecoder().decode(base64Str)}

   Scenario: pathMatches('files') && methodIs('post')
    # Undocumented access to request parts
    # see https://github.com/intuit/karate/blob/v1.0.1/karate-core/src/main/java/com/intuit/karate/core/MockHandler.java#L151
     * match requestParts contains {'file':'#[1]'}
     * def filePart = requestParts['file'][0]
     * def fileId = nextId()

     # Print all fields in part.
     * print filePart

     # binary file content is stored in 'value' field as a byte array
     # We want to store that file content as a base64 encoded string.
     # That's a common way to exchange binary content within json.
     * def base64EncodedContent = encode(filePart.value);

     # Add our new file to your 'files' collection
     * files[fileId] = {id: fileId, name: filePart.filename, contentType: filePart.contentType, content: base64EncodedContent}
     * def response = files[fileId]

   Scenario: pathMatches('files/{fileId}') && methodIs('get') && acceptContains('json')
    * def response = files[pathParams.fileId]

  Scenario: pathMatches('files/{fileId}/content') && methodIs('get')
    * def file = files[pathParams.fileId]
    * def response = decode(file.content)
    * def responseHeaders = { 'Content-Type': #(file.contentType) }
  
  Scenario:
    * print `catch all rule matched: ${requestMethod}:${requestUrlBase}/${requestUri}`
    * print 'With Headers:'
    * print requestHeaders
    * print 'With Request Parameters'
    * print requestParams
    * print 'And Request:'
    * print request

    * def responseStatus = 200
    * def response = {status:'catch all'}