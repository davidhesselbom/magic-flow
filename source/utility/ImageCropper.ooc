use draw
use draw-gpu
use flow
use geometry
use opengl

ImageCropper: class extends Modifier {
	_context : DrawContext
	_boxLeft : Float
	_boxTop : Float
	_boxWidth : Float
	_boxHeight : Float
	init: func(=_context, =_boxLeft, =_boxTop, =_boxWidth, =_boxHeight) {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		input := frame data as OpenGLMonochrome
		result := input create()
		box := FloatBox2D new(this _boxLeft, this _boxTop, this _boxWidth, this _boxHeight)
		DrawState new(result) setInputImage(frame data) setSourceNormalized(box) draw()
		frame update(result)
	}
}
