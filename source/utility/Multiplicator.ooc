use draw
use draw-gpu
use opengl
use flow

Multiplicator: class extends Synchronizer {
	_context : DrawContext
	init: func (=_context) {
		super(2)
	}
	merge: override func (frames: Frame[]) -> Frame {
		map := OpenGLMapTransform new(slurp("Multiplicator.frag"), this _context as OpenGLContext)
		map add("texture0", frames[0] data)
		map add("texture1", frames[1] data)
		result := frames[0] data as OpenGLMonochrome create()
		DrawState new(result) setMap(map) draw()
		frames[1] update(result)
	}
}
