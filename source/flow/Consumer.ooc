use draw
use flow

Consumer: abstract class extends Filter {
	init: func {
		super(0)
	}
	receive: abstract func (frame: Frame)
	_receive: func (frame: Frame) {
		//this receive(frame)
		stdout write(frame data as RasterYuv420Semiplanar y buffer pointer as Char*, 0, frame data size area)
	}
	getInput: override func (index: Int) -> Func(Frame) {
		result: Func(Frame)
		if (index == 0)
			result = func(frame: Frame) { this _receive(frame) }
		else
			result = func(frame: Frame) { }
		result
	}
}
