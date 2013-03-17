{Component} = require '../app/Component'

exports.ComponentTest =
	'test constructor': (test) ->
		component = new Component()
		test.ok(component.id isnt null)
		console.log(component.id)
		test.done()