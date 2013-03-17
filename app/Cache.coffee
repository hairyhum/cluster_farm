{Config} = require './Config'
{Events} = require './Observer'
{Processor} = require './Processor'

class Cache extends Processor
  reserveRead: () ->
    Config.cache_reserve_read
  events: () ->
    [Events.read_request]
  
exports.Cache = Cache