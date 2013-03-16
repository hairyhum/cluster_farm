{Processor} = require './Processor'
{Config} = require './Config'

class App extends Processor
  reserveRead: () ->
    Config.app_reserve_read

  reserveWrite: () ->
    Config.app_reserve_write

exports.App = App