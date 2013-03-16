{Config} = require './Config'
{Network} = require './Network'
{Router} = require './Router'

class Schema
  constructor: () ->
    @components = [new Client()]
    @networks = []
    @routers = []

  addComponent: (component) ->
    @components.push component

  removeComponent: (component) ->
    @components = @components.filter (c) -> c isnt component
    @optimize()

  componentSource: (dest) ->
    network = dest.source
    if network.source instanceof Router
      network.source.source
    else
      network.source

  connectComponents: (src, dest) ->
    #TODO: assert not router or network
    unless @isConnected src, dest
      network = new Network
      network.add_dest dest

      net_src = if src.hasDestinations
        old_destination = src.destinations[0]
        if old_destination instanceof Router
          old_destination
        else if old_destination instanceof Network
          old_destination.remove_source
          router = new Router
          router.add_dest old_destination
          src.add_dest router
          router
      else
        src
      real_src.add_dest network
    @optimize()

  disconnectComponents: (src, dest) ->
    #TODO: assert not router or network
    if @isConnected src, dest
      network = dest.source
      dest.remove_source
      net_src = network.source
      network.remove_source
      if net_src instanceof Router
        router.optimize
    @optimize()

  isConnected: (src, dest) ->
    componentSource(dest) is src
      
  optimize: () ->
    @networks.forEach (n) -> n.optimize()
    @routers.forEach (r) -> r.optimize()
    @networks = @networks.filter (n) -> n.source?
    @routers = @routers.filter (r) -> r.source?

  validate: () ->
    @optimize()
    not @hasLoops() and not @hasNetworkTrees()

  
  hasLoops: () ->
    hasLocalLoops = (component) ->
    sources = []
    sources.push = component.source
    loopFun = (component) ->
      if (sources.filter (s) -> s is component.source).length > 0
        return true
      unless component.source?
        return false
      sources.push component.source
      loopFun component.source

    loopFun component.source

    components.some hasLocalLoops
    
  hasNetworkTrees: () ->
    network_loops = @networks.some (n) ->
      n.source instanceof Network or network.destination() instanceof Network
    router_loops = @routers.some (r) ->
      r.source instanceof Router or 
      r.source.source instanceof Router


exports.Schema = Schema



