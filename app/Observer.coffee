class Observer
  constructor: () ->
    @subscribers = {}
    
  subscribe: (event, fn) ->
    if @subscribers[event]?
      @subscribers[event] = []
    @subscribers[event].push fn

  unsubscribe: (event, fn) ->
    if @subscribers[event]?
      @subscribers[event] = @subscribers[event].filter (el) -> el isnt fn

  fire: (event, param) ->
    event_subscribers = @event_subscribers(event)
    event_subscribers.forEach (subscr) -> subscr(param)

Events = 
  terminate: 'terminate'
  read_request: 'read_request'
  write_request: 'write_request'

