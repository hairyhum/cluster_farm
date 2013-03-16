class Observer
  constructor: () ->
    @subscribers = []

  subscribe: (fn) ->
    @subscribers.push fn

  unsubscribe: (fn) ->
    @subscribers = @subscribers.filter (el) -> el isnt fn

  fire: (event, param) ->
    @subscribers.forEach (subscr) -> 
      subscr(event, param)


Events = 
  terminate: 'terminate'
  read_request: 'read_request'
  write_request: 'write_request'