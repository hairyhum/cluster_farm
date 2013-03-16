class Router extends Component
  latency: () -> Config.router_latency

  event_subscribers: (event) ->
    event_subscribers = @subscribers[event]
    if event_subscribers?
      length = event_subscribers.length
      [
        event_subscribers[random_choice(length)]
      ]

  random_choice: (count) ->
    Math.floor(Math.random() * count)