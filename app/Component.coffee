class Component
  constructor: () ->
    @subscribers = {}
    @destinations = []


  subscribe: (event, fn) ->
    if @subscribers[event]?
      throw "trying to redefine subscriber"
    @subscribers[event] = fn

  unsubscribe: (event, fn) ->
    @subscribers[event] = undefined

  fire: (event, param) ->
    @subscribers[event]?(param)

  connect_to_source: (source) ->
    source.add_dest @

  add_dest: (dest) ->
    @destinations.push dest
    events = dest.events()
    events.forEach (event) ->
      source.subscribe event, (req) ->
        dest.process req

  passRequest: (req) ->
    @fire req.passingEvent, req

  process: (req) ->
    req.incAge @latency()
    callback = if @destinations == []
      () -> req.terminate()
    else
      () => @passRequest req
      
    timeout = Config.latency_ratio * @latency()
    setTimeout callback, timeout

  events: () ->
    [Events.read_request, Events.write_request]