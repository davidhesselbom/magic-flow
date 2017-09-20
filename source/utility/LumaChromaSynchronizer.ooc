use draw
use flow

LumaChromaSynchronizer: class extends Synchronizer {
	init: func {
		super(2)
	}
	merge: override func (frames: Frame[]) -> Frame {
		frames[0] update(RasterYuv420Semiplanar new(frames[0] data as RasterYuv420Semiplanar y, frames[1] data as RasterYuv420Semiplanar uv))
	}
}
