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
		if (this _data != null && this _data instanceOf(Image)) // segfault here is due to data being a dangling pointer after that the Image has been deallocated when reducing the reference counter below 1
			this _data as Image referenceCount update(delta)
	}
	increaseReferenceCount: func { this updateReferenceCount(1) }
	decreaseReferenceCount: func { this updateReferenceCount(-1) }
	debug: func(identifier: String) {
		if (this _data != null && this _data instanceOf(Image))
			("#" + this serial toString() + " " + identifier + " " + this _data as Image referenceCount count toString()) println()
		else
			("#" + this serial toString() + " " + identifier + " no data") println()
	}
}
