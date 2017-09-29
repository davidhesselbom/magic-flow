use flow
use draw
use draw-gpu
use opengl
use geometry

Cropper: class extends Modifier {
	_cutout: FloatBox2D
	init: func(=_cutout) {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		input := frame data as Image
		result := input create(this _cutout size toIntVector2D())
		DrawState new(result) setInputImage(input) setSourceNormalized(this _cutout) draw()
		frame update(result)
	}
}
