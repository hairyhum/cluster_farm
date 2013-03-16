{Request, RequestType} = require '../app/Request'

exports.RequestTest =
	# getReadType: () -> 
	# getWriteType: () -> RequestType.read
	# getTimeout: () -> 600
	# getAge: () -> 0

	setUp: (callback) ->
        @request = new Request(RequestType.read, 600)
        callback()

	'test constructor': (test) ->
		test.equal(@request.type, RequestType.read)
		test.equal(@request.timeout, 600)
		test.equal(@request.age, 0)
		test.done()

	'test isRead true': (test) ->
		test.equal(@request.isRead(), true)
		test.done()

	'test isWrite false': (test) ->
		test.equal(@request.isWrite(), false)
		test.done()

	'test incAge': (test) ->
		@request.incAge(100)
		test.equal(@request.age, 100)
		test.done()

	'test isFailed': (test) ->
		@request.incAge(600)
		test.equal(@request.isFailed(), true)
		test.done()

	'test isFailed true': (test) ->
		@request.incAge(700)
		test.equal(@request.isFailed(), true)
		test.done()

	'test isPassed true': (test) ->
		@request.incAge(100)
		test.equal(@request.isPassed(), true)
		test.done()
