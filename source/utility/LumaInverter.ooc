use flow
use draw
use draw-gpu
use opengl

LumaInverter: class extends Modifier {
	_context : DrawContext
	init: func(=_context) {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		input := frame data as OpenGLMonochrome
		map := OpenGLMapTransform new(slurp("LumaInverter.frag"), this _context as OpenGLContext)
		map add("texture0", input)
		result := input create()
		DrawState new(result) setMap(map) draw()
		frame update(result)
	}
}
