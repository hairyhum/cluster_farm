{Simulator} = require './app/Simulator'
{Web, Schema} = Simulator
schema = new Schema
root = schema.addComponent new Web
schema.setRoot root
schema.client.run 10, 10, 100, 0.5
