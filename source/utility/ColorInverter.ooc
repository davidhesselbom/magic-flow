use flow
use draw
use draw-gpu
use opengl

ColorInverter: class extends Modifier {
	_context : DrawContext
	init: func(=_context) {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		input := frame data as GpuYuv420Semiplanar
		map := OpenGLMapTransform new(slurp("ColorInverter.frag"), this _context as OpenGLContext)
		map add("texture0", input y)
		map add("texture1", input uv)
		result := input create()
		DrawState new(result) setMap(map) draw()
		frame update(result)
	}
}
