use flow
use draw
use draw-gpu

FromGpu: class extends Modifier {
	init: func {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		frame update(frame data as GpuImage toRaster())
	}
}
