use draw

Frame: cover {
	_serial: ULong
	serial ::= this _serial
	_data: Image
	data ::= this _data
	init: func@ (serial: ULong, data: Image) {
		this _serial = serial
		this _data = data
	}
	update: func (data: Image) -> This {
		This new(this serial, data)
	}
	updateReferenceCount: func (delta: Int) {
		if (this _data != null)
			this _data referenceCount update(delta)
	}
	increaseReferenceCount: func { this updateReferenceCount(1) }
	decreaseReferenceCount: func { this updateReferenceCount(-1) }
}
