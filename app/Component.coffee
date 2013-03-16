{Events} = require './Observer'
{Config} = require './Config'

class Component
  constructor: () ->
    @subscribers = {}
    @destinations = []

  destination: () ->
    @destinations[0]?.component

  subscribe: (event, fn) ->
    if @subscribers[event]?
      throw "trying to redefine subscriber"
    @subscribers[event] = fn

  unsubscribe: (event, fn) ->
    @subscribers[event] = undefined

  fire: (event, param) ->
    @subscribers[event]?(param)

  add_source: (source) ->
    source.add_dest @

  remove_source: () ->
    @source.remove_dest @

  add_dest: (component) ->
    component.source = @
    callback = (req) ->
      component.process req
    @destinations.push {
      component: component
      callback: callback
    }
    events = component.events()
    events.forEach (event) =>
      @subscribe event, callback

  remove_dest: (component) ->
    {component, callback} = (@destinations.filter (dest) ->
      dest.component is component)[0]
    events = component.events()
    events.forEach (event) =>
      @unsubscribe event, callback
    @destinations = @destinations.filter (dest) ->
      dest.component isnt component
    component.source = undefined

  hasDestinations: () ->
    @destinations.length > 0

  passRequest: (req) ->
    @fire req.passingEvent(), req

  process: (req) ->
    callback = @processCallback req
    timeout = Config.latency_ratio * @latency()
    setTimeout callback, timeout
  
  processCallback: (req) ->
    if @destinations.length == 0
      () => 
        req.incAge @latency()
        # console.log req.age
        req.terminate()
    else
      () => 
        req.incAge @latency()
        @passRequest req
      


  events: () ->
    [Events.read_request, Events.write_request]

exports.Component =  Component