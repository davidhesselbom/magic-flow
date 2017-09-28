use draw

Frame: cover {
	_serial: ULong
	serial ::= this _serial
	_data: Object
	data ::= this _data
	init: func@ (=_serial, =_data)
	update: func (data: Object) -> This {
		This new(this serial, data)
	}
	updateReferenceCount: func (delta: Int) {
		if (this _data != null && this _data class instanceOf(Image))
			this _data as Image referenceCount update(delta)
	}
	increaseReferenceCount: func { this updateReferenceCount(1) }
	decreaseReferenceCount: func { this updateReferenceCount(-1) }
}
