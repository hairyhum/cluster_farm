class Client extends Component
  constructor: () ->
    @failed = {}

  run: (concurrency, delay, rw_ratio) ->
    concurrent_requests = generate_requests(concurrency, rw_ratio)
    timeout = (delay / concurrency) * Config.latency_ratio

    concurrent_requests.asyncForEach timeout, (req, index) ->
      @passRequest req

Array::asyncForEach = (timeout, fn) ->
  index = 0
  iterFun = () =>
    unless index is @length
      fn(@[index], index++)
      setTimeout iterFun, timeout
  setTimeout(iterFun, 0)

  

