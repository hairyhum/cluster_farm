class Component extends Observer
  constructor: () ->

  connect: (comp) ->
    comp.subscribe event, (req) =>
      @process req
 
  process: (req) ->
    req.incAge @latency
    @fire req.passingEvent, req