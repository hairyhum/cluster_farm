class Constructor
	constructor: () ->
		@schema = new Schema

	addElement: (parentId, element) ->
		parentElement = @schema.getElementById(parentId)
		connectComponents(parentElement, element)	

	deleteElement: (parentId, element) ->
		parentElement = @schema.getElementById(parentId)
		disconnectComponents(parentElement)

	getStats: () ->

