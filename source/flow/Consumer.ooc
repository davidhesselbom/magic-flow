use draw
use flow

Consumer: abstract class extends Filter {
	init: func {
		super(0)
	}
	receive: abstract func (frame: Frame)
	getInput: override func (index: Int) -> Func(Frame) {
		result: Func(Frame)
		if (index == 0)
			result = func(frame: Frame) {
				//frame debug("consumer before receive")
				this receive(frame)
				frame debug("consumer after receive")
				//frame decreaseReferenceCount()
			}
		else
			result = func(frame: Frame) { }
		result
	}
}
