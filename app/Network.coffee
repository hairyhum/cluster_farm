{Component} = require 'Component'
{Config} = require 'Config'

class Network extends Component
  latency: () -> Config.network_latency
  optimize: () -> 
    if @source instanceof Network
      source = @source.source
      @remove_source
      @add_source source
    if @destination() instanceof Network
      dest = @destination().destination()
      @remove_dest @destination()
      @add_dest dest

    unless @destination()?
      @remove_source

    unless @source
      @remove_dest @destination()


exports.Network = Network