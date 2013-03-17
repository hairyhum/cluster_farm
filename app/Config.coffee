Config = 
  app_reserve_write: 1
  app_reserve_read: 3
  
  db_reserve_write: 1
  db_reserve_read: 3

  web_reserve_write: 4
  web_reserve_read: 4
  
  latency_ratio: 10
  network_latency: 1
  router_latency: 0
  
  resource_limit: 100

  proc_min_latency: 1
  proc_max_latency: @resource_limit

exports.Config = Config