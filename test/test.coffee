<<<<<<< HEAD
  {Simulator} = require './app/Simulator'
  {App, Web, DB, Schema} = Simulator
  schema = new Schema
  web = schema.addComponent new Web
  app = schema.addComponent new App
  db = schema.addComponent new DB
  schema.connectComponents app, db
  schema.setRoot web
  schema.client.run 15, 10, 100, 0.5
  console.log schema.client.report()

  schema.setRoot app
  schema.client.run 15, 10, 100, 0.5
  console.log schema.client.report()
=======
# {Simulator} = require './app/Simulator'
# {Web, Schema} = Simulator
# schema = new Schema
# root = schema.addComponent new Web
# schema.setRoot root
# schema.client.run 10, 10, 100, 0.5
>>>>>>> add constructor
