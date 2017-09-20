use flow
use draw
use draw-gpu

ToMonochrome: class extends Modifier {
	init: func {
		super()
	}
	modify: override func (frame: Frame) -> Frame {
		result := match (frame data) {
			case gpuImage: GpuYuv420Semiplanar =>
				gpuImage as GpuYuv420Semiplanar y
			case cpuImage: RasterYuv420Semiplanar =>
				cpuImage as RasterYuv420Semiplanar y
		}
		frame update(result)
	}
}
