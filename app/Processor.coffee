{Component} = require './Component'
{Config} = require './Config'
{Events} = require './Observer'

class Processor extends Component
  constructor: () ->
    @resource_limit = Config.resource_limit
    @resource_reserved = 0
    super()

  processCallback: (req) ->
    reserves = @requestReserves(req)
    new_reserved = @resource_reserved + reserves 
    if new_reserved > @resource_limit
      () => 
        req.incAge @latency()
        @process(req)
    else
      @resource_reserved = new_reserved
      req.subscribe Events.terminate, (req) =>
        @resource_reserved -= reserves
      super(req)
  

  requestReserves: (req) ->
    if req.isRead()
      @reserveRead()
    else if req.isWrite()
      @reserveWrite()

  latency: () ->
    @min_latency() + Math.pow(@exp_base(), @resource_reserved)

  exp_base: () ->
    lat_diff = @max_latency() - @min_latency()
    @min_latency() + (5 / lat_diff)

  max_latency: () ->
    Config.proc_max_latency

  min_latency: () ->
    Config.proc_min_latency

exports.Processor = Processor