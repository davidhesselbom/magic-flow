use flow

Filter: abstract class {
	_outputs: Vector<VectorList<Func(Frame)>>
	init: func (outputCount: Int) {
		this _outputs = HeapVector<VectorList<Func(Frame)>> new(outputCount)
		for (i in 0 .. outputCount)
			this _outputs[i] = VectorList<Func(Frame)> new()
	}
	getInput: virtual func (index: Int) -> Func(Frame) {
		func(frame: Frame) { }
	}
	send: func (output: Int, frame: Frame) {
		sendList := this _outputs[output]
		for (i in 0 .. sendList count)
			sendList[i](frame)
	}
	connect: func (output: Int, next: This, input: Int) -> This {
		this _outputs[output] add(next getInput(input))
		next
	}
	connect: func ~defaultOutput (next: This, input: Int) -> This {
		this connect(0, next, input)
	}
	connect: func ~defaultInput (output: Int, next: This) -> This {
		this connect(output, next, 0)
	}
	connect: func ~default (next: This) -> This {
		this connect(0, next, 0)
	}
}
