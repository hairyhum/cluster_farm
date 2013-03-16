{Component} = require './Component'
{Config} = require './Config'
{Events} = require './Observer'

class Processor extends Component
  constructor: () ->
    @resource_limit = Config.resource_limit
    @resource_reserved = 0

  process: (req) ->
    @reserveResource(req)
    super req

  reserveResource: (req) ->
    @resource_reserved += @requestReserves(req)
    req.subscribe Events.terminate, (req) =>
      @resource_reserved -= @requestReserves(req)

  requestReserves: (req) ->
    if req.isRead()
      reserveRead()
    else if req.isWrite()
      reserveWrite()

  latency: () ->
    min_latency + Math.pow(@exp_base(), @resource_reserved)

  exp_base: () ->
    max_latency = @max_latency()
    min_latency = @min_latency()
    val = Math.log (max_latency - min_latency)
    base = Math.log 100
    val / base

  max_latency: () ->
    Config.proc_max_latency

  min_latency: () ->
    Config.proc_min_latency
      
exports.Processor = Processor