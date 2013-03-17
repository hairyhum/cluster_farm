{Simulator} = require '../app/Simulator'
{Web, Schema, Request, RequestType, Events, Component} = Simulator

exports.ObserverTest =
	setUp: (callback) ->
		callback()

	'test Schema': (test) ->
		schema = new Schema
		root = schema.addComponent new Web
		schema.setRoot root

		testRequest = new Request(RequestType.read, 600)

		console.log(schema.client.reset())
		console.log(schema.client.run 15, 10, 100, 0.5)
		console.log(schema.client.onRequestTerminated(testRequest))
		console.log(schema.client.generate_requests(10, 100, 0.5))

		console.log('sleep')
		setTimeout ( ->
			console.log(schema.client.subscribers[Events.read_request])
			console.log(schema.client.subscribers[Events.write_request])
			console.log(schema.client.destinations[0].component)
		), 2000

		console.log("root")
		console.log(root.reserveRead())
		console.log(root.reserveWrite())
		console.log(root.process(testRequest))
		# console.log(root.reserveResource(testRequest))
		console.log(root.requestReserves(testRequest))
		console.log(root.latency())
		console.log(root.exp_base())
		console.log(root.min_latency())
		console.log(root.max_latency())

		console.log(root.destination())


		test.equal(1, 1)
		test.done()

	'test get element by id': (test) ->
		schema = new Schema
		c1 = schema.addComponent new Web
		schema.setRoot c1
		console.log(c1.id)
		c2 = schema.addComponent new Component
		test.equal(c2.id, schema.getElementById(c2.id).id)
		test.done()