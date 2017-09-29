use draw
use draw-gpu
use opengl
use flow

LumaChromaSynchronizer: class extends Synchronizer {
	init: func {
		super(2)
	}
	merge: override func (frames: Frame[]) -> Frame {
		y := match(frames[0] data) {
			case monochrome: RasterMonochrome =>
				monochrome
			case rasterYuv: RasterYuv420Semiplanar =>
				rasterYuv as RasterYuv420Semiplanar y
		}
		frames[0] update(RasterYuv420Semiplanar new(y, frames[1] data as RasterYuv420Semiplanar uv))
	}
}

ItemSynchronizer: class extends Synchronizer {
	_context : DrawContext
	init: func (=_context) {
		super(2)
	}
	merge: override func (frames: Frame[]) -> Frame {
		map := OpenGLMapTransform new(slurp("ItemSynchronizer.frag"), this _context as OpenGLContext)
		map add("texture0", frames[0] data)
		map add("texture1", frames[1] data)
		result := frames[0] data as OpenGLMonochrome create()
		DrawState new(result) setMap(map) draw()
		frames[1] update(result)
	}
}
