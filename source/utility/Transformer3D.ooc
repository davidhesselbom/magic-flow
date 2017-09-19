use draw
use flow
use geometry

Transformer3D: class extends Modifier {
	_transform := FloatTransform3D createRotationX(5.0f toRadians())
	init: func {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		result := frame data create()
		DrawState new(result) setFocalLengthNormalized(0.1f) setTransformReference(this _transform) setInputImage(frame data) draw()
		frame update(result)
	}
}
