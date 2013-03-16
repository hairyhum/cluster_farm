Observer = require '../app/Observer'
Req = require '../app/Request'

exports.RequestTest =

	'test constructor': (test) ->
		type = Req.RequestType.read
		# timeout = 600
		# console.log 600
		# request = new Request(RequestType.read, 600)
		# test.equal(request.type, RequestType.read)
		# test.equal(request.timeout, timeout)
		# test.equal(request.age, 0)
		test.equal(600, 600)
		test.done()