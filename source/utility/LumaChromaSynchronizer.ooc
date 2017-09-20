use draw
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
