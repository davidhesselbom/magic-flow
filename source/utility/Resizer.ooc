use flow
use draw
use draw-gpu
use opengl

Resizer: class extends Modifier {
	_divisor : Int
	init: func(=_divisor) {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		frame update(frame data as Image resizeTo(frame data as Image size / this _divisor))
	}
}
