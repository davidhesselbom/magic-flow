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
		input := frame data as GpuYuv420Semiplanar
		map := OpenGLMapTransform new(slurp("LumaInverter.frag"), this _context as OpenGLContext)
		map add("texture0", input y)
		result := input y create()
		DrawState new(result) setMap(map) draw()
		frame update(this _context createYuv420Semiplanar(result as GpuImage, input uv))
	}
}
