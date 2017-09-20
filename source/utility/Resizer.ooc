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
		frame update(frame data resizeTo(frame data size / this _divisor))
	}
}
