{Events, Observer} = require './Observer'

class Request extends Observer
  constructor: (@type, @timeout) ->
    @age = 0
    super
  
  event_subscribers: (event) ->
    @subscribers[event]
   
  isRead: () -> @type == RequestType.read
  isWrite: () -> @type == RequestType.write
  
  incAge: (time) -> 
    @age += time

  terminate: () ->
    @fire(Events.terminate, @)    

  passingEvent: () ->
    if @isRead()
      Events.read_request
    else if @isWrite()
      Events.write_request

  isFailed: () ->
    @age >= @timeout

  isPassed: () ->
    @age < @timeout

RequestType = 
  read: 'read'
  write: 'write'

exports.Request = Request
exports.RequestType = RequestType