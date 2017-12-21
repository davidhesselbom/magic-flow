use draw
use draw-gpu
use opengl
use flow

Multiplicator: class extends Synchronizer {
	_map: OpenGLMapTransform
	init: func (context: OpenGLContext) {
		super(2)
		this _map = OpenGLMapTransform new(slurp("Multiplicator.frag"), context)
	}
	merge: override func (frames: Frame[]) -> Frame {
		this _map add("texture0", frames[0] data)
		this _map add("texture1", frames[1] data)
		result := frames[0] data as OpenGLMonochrome create()
		DrawState new(result) setMap(this _map) draw()
		frames[1] update(result)
	}
}
