{Observer, Events} = require '../app/Observer'

exports.ObserverTest =
	setUp: (callback) ->
		@observer = new Observer()
		callback()

	'test constructor': (test) ->
		test.ok(@observer.subscribe isnt null)
		test.done()

	'test subscribe': (test) ->
		@observer.subscribe(Events.read_request, () -> test.equal(1, 1))
		test.equal(1, 1)
		test.done()
