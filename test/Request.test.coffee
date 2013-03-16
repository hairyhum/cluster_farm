{Events} = require '../app/Observer'
{Request, RequestType} = require '../app/Request'

exports.RequestTest =
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

	'test isFailed false': (test) ->
		@request.age = 500
		test.equal(@request.isFailed(), false)
		test.done()

	'test isFailed true >': (test) ->
		@request.incAge(700)
		test.equal(@request.isFailed(), true)
		test.done()

	'test isFailed true =': (test) ->
		@request.age = @request.timeout
		test.equal(@request.isFailed(), true)
		test.done()

	'test isPassed true <': (test) ->
		@request.incAge(100)
		test.equal(@request.isPassed(), true)
		test.done()

	'test isPassed false =': (test) ->
		@request.age = @request.timeout
		test.equal(@request.isPassed(), false)
		test.done()

	'test isPassed false >': (test) ->
		@request.incAge(600)
		test.equal(@request.isPassed(), false)
		test.done()

	'test passingEvent true': (test) ->
		test.equal(@request.passingEvent(), Events.read_request)
		test.done()

	'test event_subscribes': (test) ->
		test.equal(@request.event_subscribers(Events.read_request), @request.subscribers[Events.read_request])
		test.done()

	'test terminate': (test) ->
		req = new Request(RequestType.write, 300)
		@request.subscribe(Events.terminate, () -> test.equal(1, 1))
		@request.terminate()
		test.done()
