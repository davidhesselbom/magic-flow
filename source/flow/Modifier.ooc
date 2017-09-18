use flow

Modifier: abstract class extends Filter {
	init: func {
		super(1)
	}
	modify: abstract func (frame: Frame) -> Frame
	getInput: override func (index: Int) -> Func(Frame) {
		result: Func(Frame)
		if (index == 0)
			result = func(frame: Frame) { this send(0, this modify(frame)) }
		else
			result = func(frame: Frame) { }
		result
	}
}
