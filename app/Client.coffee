{Request, RequestType} = require './Request'
{Events} = require './Observer'
{Component} = require './Component'
{Config} = require './Config'
{Timeouts} = require './Time'


class Client extends Component
  constructor: () ->
    @reset()
    super()

  reset: () ->
    Timeouts.clearTimeouts()
    @failed =
      read: 0
      write: 0

    @passed =
      read: 0
      write: 0

  terminate: () ->
    Timeouts.clearTimeouts()

  run: (concurrency, delay, request_timeout, rw_ratio) ->
    @reset()
    concurrent_requests = @generate_requests(concurrency, request_timeout, rw_ratio)
    timeout = (delay / concurrency) * Config.latency_ratio
    concurrent_requests.forEach (req) =>
      req.subscribe Events.terminate, (req) =>
        @onRequestTerminated(req)
    concurrent_requests.asyncForEach timeout, (req, index) =>
      @passRequest req

  report: () ->
    {
      passed: @passed
      failed: @failed
    }
  onRequestTerminated: (req) ->
    req_type = if req.isRead()
      'read'
    else if req.isWrite()
      'write'
    if req.isFailed()
      @failed[req_type]++
    else if req.isPassed()
      @passed[req_type]++

  generate_requests: (concurrency, request_timeout, rw_ratio) ->
    [1..concurrency].map () ->
      type = if Math.random() > rw_ratio
        RequestType.read
      else
        RequestType.write
      new Request(type, request_timeout)

Array::asyncForEach = (timeout, fn) ->
  index = 0
  iterFun = () =>
    unless index is @length
      fn(@[index], index++)
      Timeouts.addTimeout iterFun, timeout
  Timeouts.addTimeout iterFun, 0

exports.Client = Client