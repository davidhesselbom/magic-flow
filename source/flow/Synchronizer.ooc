use flow
_Storage: class {
	_serial: ULong
	_filled: Int
	_frames: Frame[]
	_send: Func(Frame[])
	count ::= this _frames length
	init: func(sinks: Int, =_send) {
		this _frames = Frame[sinks] new()
	}
	reset: func (serial: Int)
	{
		this _serial = serial
		this _filled = 0
	}
	insert: func (sink: Int, frame: Frame) {
		if (frame serial >= this _serial) {
			if (frame serial > this _serial)
				this reset(frame serial)
			// frame increaseReferenceCount()
			// this _frames[sink] decreaseReferenceCount()
			this _frames[sink] = frame
			this _filled += 1
			if (this _filled == this _frames length)
				this _send(this _frames)
		}
	}
}
Synchronizer: abstract class extends Filter {
	_backend: _Storage
	init: func(sinks: Int) {
		super(1)
		this _backend = _Storage new(sinks, func(frames: Frame[]) {
			result := this merge(frames)
			result increaseReferenceCount()
			for (i in 0 .. frames length)
				frames[i] decreaseReferenceCount()
			this send(0, result)
		})
	}
	merge: abstract func (frames: Frame[]) -> Frame
	getInput: override func (index: Int) -> Func(Frame) {
		result: Func(Frame)
		if (index < this _backend count)
			result = func(frame: Frame) { this _backend insert(index, frame) }
		else
			result = func(frame: Frame) { }
		result
	}
}
