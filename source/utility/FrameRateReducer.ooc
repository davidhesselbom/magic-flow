use flow

FrameRateReducer: class extends Filter {
	_divisor: Int
	init: func (=_divisor) {
		super(1)
	}
	getInput: override func (index: Int) -> Func(Frame) {
		result: Func(Frame)
		if (index == 0)
			result = func(frame: Frame) {
				if (frame serial % this _divisor == 0)
					this send(0, frame)
			}
		else
			result = func(frame: Frame) { }
		result
	}
}
