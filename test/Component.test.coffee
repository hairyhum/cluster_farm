{Component} = require '../app/Component'

exports.ComponentTest =
	'test constructor': (test) ->
		component = new Component()
		test.ok(component.getId() isnt null)
		console.log(component.getId())
		test.done()