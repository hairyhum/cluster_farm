class Request extends Observer
  constructor: (@type, @timeout) ->
    @age = 0
  
  isRead: () -> @type == RequestType.read
  isWrite: () -> @type == RequestType.write
  
  incAge: (time) -> 
    @age += time

  terminate: () ->
    @fire(Events.terminate)    


RequestType = 
  read: 'read'
  write: 'write'