{Config} = require './Config'
{Processor} = require './Processor'
class Web extends Processor
  reserveRead: () ->
    Config.web_reserve_read

  reserveWrite: () ->
    Config.web_reserve_write

exports.Web = Web  