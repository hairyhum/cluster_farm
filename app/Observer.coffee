class Observer
  constructor: () ->
    @subscribers = {}

  subscribe: (event, fn) ->
    unless @subscribers[event]?
      @subscribers[event] = []
    @subscribers[event].push fn

  unsubscribe: (event, fn) ->
    if @subscribers[event]?
      @subscribers[event] = @subscribers[event].filter (el) -> el isnt fn

  fire: (event, param) ->
    @subscribers[event]?.forEach (subscr) -> 
      subscr(param)

Events = 
  terminate: 'terminate'
  read_request: 'read_request'
  write_request: 'write_request'