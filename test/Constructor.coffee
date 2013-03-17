{Simulator} = require '../app/Simulator'
{Web, Schema, Request, RequestType, Events, Component, Constructor} = Simulator

exports.constrTest =
	'test addElement': (test) ->
		# type = Web
		# o = new type
		# console.log(o)
		@constr = new Constructor()	
		@constr.addElement(Web)
		test.equal(2, @constr.schema.components.length)
		@constr.addElement(Web)
		test.equal(3, @constr.schema.components.length)
		test.done()


	# 'test Schema': (test) ->
	# 	schema = new Schema
	# 	root = schema.addComponent new Web
	# 	schema.setRoot root

	# 	testRequest = new Request(RequestType.read, 600)

	# 	console.log(schema.client.reset())
	# 	console.log(schema.client.run 15, 10, 100, 0.5)
	# 	console.log(schema.client.onRequestTerminated(testRequest))
	# 	console.log(schema.client.generate_requests(10, 100, 0.5))

	# 	console.log('sleep')
	# 	setTimeout ( ->
	# 		console.log(schema.client.subscribers[Events.read_request])
	# 		console.log(schema.client.subscribers[Events.write_request])
	# 		console.log(schema.client.destinations[0].component)
	# 	), 2000

	# 	console.log("root")
	# 	console.log(root.reserveRead())
	# 	console.log(root.reserveWrite())
	# 	console.log(root.process(testRequest))
	# 	console.log(root.reserveResource(testRequest))
	# 	console.log(root.requestReserves(testRequest))
	# 	console.log(root.latency())
	# 	console.log(root.exp_base())
	# 	console.log(root.min_latency())
	# 	console.log(root.max_latency())

	# 	console.log(root.destination())


	# 	test.equal(1, 1)
	# 	test.done()