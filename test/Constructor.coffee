{Simulator} = require '../app/Simulator'
{Web, Schema, Request, RequestType, Events, Component, Constructor, DB, App} = Simulator

exports.constrTest =
	'test addElement': (test) ->
		@constr = new Constructor()	
		@constr.addElement(Web)
		test.equal(2, @constr.schema.components.length)
		@constr.addElement(Web)
		test.equal(3, @constr.schema.components.length)
		test.done()

	'test deleteElement': (test) ->
		@constr = new Constructor()	
		@constr.addElement(Web)
		test.equal(2, @constr.schema.components.length)
		id = @constr.addElement(DB)
		test.equal(3, @constr.schema.components.length)
		@constr.deleteElement(id)
		test.equal(2, @constr.schema.components.length)
		test.done()

	'test connectElement': (test) ->
		@constr = new Constructor()	
		first = @constr.addElement(Web)
		test.equal(2, @constr.schema.components.length)
		second = @constr.addElement(DB)
		test.equal(3, @constr.schema.components.length)
		@constr.connectElement(first, second)
		test.ok(@constr.validate)
		test.done()

	'test disconnectElement': (test) ->
		@constr = new Constructor()	
		first = @constr.addElement(Web)
		test.equal(2, @constr.schema.components.length)
		second = @constr.addElement(DB)
		test.equal(3, @constr.schema.components.length)
		@constr.connectElement(first, second)
		test.ok(@constr.validate)
		@constr.disconnectElement(first, second)
		test.ok(@constr.validate)
		test.done()

	'test disconnectElement': (test) ->
		@constr = new Constructor()	
		id = @constr.addElement(App)
		test.equal(2, @constr.schema.components.length)
		@constr.setRoot(id);
		test.ok(@constr.validate)
		@constr.disconnectElement(id, @constr.schema.client.id)
		test.equal(2, @constr.schema.components.length)
		test.ok(@constr.validate)
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