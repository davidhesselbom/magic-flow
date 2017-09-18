use flow

Filter: abstract class {
	_outputs: Vector<VectorList<Func(Frame)>>
	init: func (outputCount: Int) {
		this _outputs = HeapVector<VectorList<Func(Frame)>> new(outputCount)
		for (i in 0 .. outputCount) {
			this _outputs[i] = VectorList<Func(Frame)> new()
		}
	}
	getInput: abstract func (index: Int) -> Func(Frame)
	send: func (output: Int, frame: Frame) {
		sendList := this _outputs[output]
		for (i in 0 .. sendList count) {
			sendList[i](frame)
		}
	}
	connect: func (output: Int, next: This, input: Int) -> This {
		this _outputs[output] add(next getInput(input))
		next
	}
}
