use draw

Frame: cover {
	_serial: ULong
	serial ::= this _serial
	_data: Image
	data ::= this _data
	_referenceCount: Int
	init: func@ (serial: ULong, data: Image) {
		this _serial = serial
		this _data = data
	}
	update: func (data: Image) -> This {
		This new(this serial, data)
	}
	updateReferenceCount: func (delta: Int) {
		this _data referenceCount update(delta)
		this _referenceCount += delta
		(" frame: " + this serial toString() + " delta: " + delta + " refC: " + this _data referenceCount toString()) println()
	}
	increaseReferenceCount: func { this updateReferenceCount(1) }
	decreaseReferenceCount: func { this updateReferenceCount(-1) }
}
