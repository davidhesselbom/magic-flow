use draw
use draw-gpu
use flow
use geometry
use opengl

FrameSynchronizer: class extends Synchronizer {
	_numberOfFrames : Int
	init: func (=_numberOfFrames) {
		super(this _numberOfFrames)
	}
	merge: override func (frames: Frame[]) -> Frame {
		result := frames[0] data create()
		result fill(ColorRgba red)
		images := this _imageCount(frames length)
		for (i in 0 .. frames length)
			DrawState new(result) setInputImage(frames[i] data) setDestinationNormalized(images[i]) draw()
		frames[0] update(result)
	}
	_imageCount: func (count: Int) -> FloatBox2D[] {
		match (count) {
			case 1 =>
				[ FloatBox2D new (0.0f, 0.0f, 1.0f, 1.0f) ]
			case 2 =>
				[ FloatBox2D new (0.0f, 0.0f, 0.5f, 1.0f), FloatBox2D new (0.5f, 0.0f, 0.5f, 1.0f) ]
			case 3 =>
				[ FloatBox2D new (0.0f, 0.0f, 0.5f, 0.5f), FloatBox2D new (0.5f, 0.0f, 0.5f, 0.5f), FloatBox2D new (0.0f, 0.5f, 0.5f, 0.5f) ]
			case 4 =>
				[ FloatBox2D new (0.0f, 0.0f, 0.5f, 0.5f), FloatBox2D new (0.5f, 0.0f, 0.5f, 0.5f), FloatBox2D new (0.5f, 0.5f, 0.5f, 0.5f), FloatBox2D new (0.0f, 0.5f, 0.5f, 0.5f) ]
			case 6 =>
				[ FloatBox2D new (0.0f, 0.0f, 0.33f, 0.5f), FloatBox2D new (0.33f, 0.0f, 0.33f, 0.5f),
					FloatBox2D new (0.66f, 0.0f, 0.34f, 0.5f), FloatBox2D new (0.0f, 0.5f, 0.33f, 0.5f),
					FloatBox2D new (0.33f, 0.5f, 0.33f, 0.5f), FloatBox2D new (0.66f, 0.5f, 0.34f, 0.5f) ]
		}
	}
}
