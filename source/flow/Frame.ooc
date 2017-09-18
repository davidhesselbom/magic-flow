use draw

Frame: cover {
	_serial: ULong
	serial ::= this _serial
	_data: Image
	data ::= this _data
	referenceCount ::= this _data referenceCount
	init: func@ (serial: ULong, data: Image) {
		this _serial = serial
		this _data = data
	}
	update: func (data: Image) -> This {
		This new(this serial, data)
	}
}
