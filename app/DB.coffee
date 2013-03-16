class DB extends Processor
  reserveRead: () ->
    Config.db_reserve_read

  reserveWrite: () ->
    Config.db_reserve_write

  