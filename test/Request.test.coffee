{Request, RequestType} = require '../app/Request'

exports.RequestTest =
	getReadType: () -> RequestType.read
	getWriteType: () -> RequestType.read
	getTimeout: () -> 600
	getAge: () -> 0

	setUp: (callback) ->
        @request = new Request(getReadType(), getTimeout())
        callback()

	'test constructor': (test) ->
		timeout = 600
		age = 0
		test.equal(@request.type, getReadType())
		test.equal(@request.timeout, getTimeout())
		test.equal(@request.age, getAge())
		test.done()