class Time
  constructor: () ->
    @timeouts = []

  addTimeout: (timeout, fn) ->
    @timeouts.push setTimeout(timeout, fn)

  clearTimeouts: () ->
    @timeouts.forEach (t) ->
      clearTimeout(t)
    @timeouts = []

exports.Time = Time
exports.Timeouts = new Time