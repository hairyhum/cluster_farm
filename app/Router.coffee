{Config} = require './Config'

class Router extends Component
  latency: () -> Config.router_latency

  event_subscribers: (event) ->
    event_subscribers = @subscribers[event]
    if event_subscribers?
      length = event_subscribers.length
      [
        event_subscribers[random_choice(length)]
      ]
  optimize: () ->
    if @destinations.length == 1
      source = @source
      dest = @destinations[0]
      @remove_source
      @remove_dest dest
      source.add_dest dest
    else if @destinations.length == 0
      @remove_source

  random_choice: (count) ->
    Math.floor(Math.random() * count)

exports.Router = Router