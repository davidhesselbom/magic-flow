use flow
use draw

ToGpu: class extends Modifier {
	_context: DrawContext
	init: func(=_context) {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		frame update(this _context createImage(frame data as RasterImage))
	}
}
