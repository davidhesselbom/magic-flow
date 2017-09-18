use base
use flow

import Sinks

Filter: abstract class {
	_outputs: Sinks[]
	init: func (outputCount: Int) {
		this _outputs = Sinks[outputCount] new()
		for (i in 0 .. outputCount)
			this _outputs[i] = Sinks new()
	}
	getInput: virtual func (index: Int) -> Func(Frame) {
		func(frame: Frame) { }
	}
	send: func (output: Int, frame: Frame) {
		receivers := this _outputs[output]
		receivers call(frame)
	}
	connect: func (output: Int, next: This, input: Int) -> This {
		this _outputs[output] = this _outputs[output] add(next getInput(input))
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
