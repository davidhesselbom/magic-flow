use flow

Modifier: abstract class extends Filter {
	modify: abstract func (frame: Frame) -> Frame
	getInput: override func (index: Int) -> Func(Frame) {
		receive := func (frame: Frame) { this send(0, this modify(frame)) }
		index == 0 ? receive : null as Func(Frame)
	}
}
