class Constructor
	constructor: () ->
		@schema = new Schema

	setRoot: (elementId) ->
		@schema.setRoot(@schema.getElementById(elementId))	

	addElement: (type) ->
		c = @schema.addComponent(new type())
		c.id
	
	deleteElement: (elementId) ->
		@schema.removeComponent(@schema.getElementById(elementId))	

	connectElement: (firstElementId, secondElementId) ->
		firstElement = @schema.getElementById(firstElementId)
		secondElement = @schema.getElementById(secondElementId)
		if @schema.isConnected(firstElement, secondElement)
			@schema.connectComponents(firstElement, secondElement)
		else
			@schema.connectComponents(secondElement, firstElement)

	disconnectElement: (firstElementId, secondElementId) ->
		firstElement = @schema.getElementById(firstElementId)
		secondElement = @schema.getElementById(secondElementId)
		if @schema.isConnected(firstElement, secondElement)
			@schema.disconnectComponents(firstElement, secondElement)
		else
			@schema.disconnectComponents(secondElement, firstElement)
	
	getStats: () ->
		@schema.components.map (c) ->
			{ id: c.id, resourceReserved: c.resource_reserved?() }
