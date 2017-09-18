use flow

Consumer: abstract class extends Filter {
	init: func {
		super(0)
	}
	receive: abstract func (frame: Frame)
	_receive: func (frame: Frame) {
		this receive(frame)
	}
	getInput: override func (index: Int) -> Func(Frame) {
		result: Func(Frame)
		if (index == 0)
			result = func(frame: Frame) { "#" println() /* this _receive(frame) */ }
		else
			result = func(frame: Frame) { }
		result
	}
}
