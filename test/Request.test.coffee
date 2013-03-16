{Request, RequestType} = require '../app/Request'

exports.RequestTest =

	'test constructor': (test) ->
		timeout = 600
		age = 0
		request = new Request(RequestType.read, timeout)
		test.equal(request.type, RequestType.read)
		test.equal(request.timeout, timeout)
		test.equal(request.age, age)
		test.done()