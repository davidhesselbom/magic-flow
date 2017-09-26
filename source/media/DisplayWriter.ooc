use draw
use draw-gpu
use io
use geometry
use flow

DisplayWriter: abstract class extends Consumer {
	_started: Bool
	init: func {
		super()
	}
	receive: override func (frame: Frame) {
		this _write(frame data as Image)
	}
	_write: func (image: Image) {
		match(image) {
			case gpuMonochrome: GpuImage =>
				this _write(gpuMonochrome toRaster())
			case cpuMonochrome: RasterMonochrome =>
				if (!this _started) {
					this _started = true
					this start(cpuMonochrome size, "gray")
				}
				this write(cpuMonochrome buffer pointer, cpuMonochrome size area)
			case coloredImage: RasterYuv420Semiplanar =>
				if (this _started == null) {
					this _started = true
					this start(coloredImage size, "yuv420p")
				}
				this write(coloredImage as RasterYuv420Semiplanar y buffer pointer, coloredImage size area)
				this write(coloredImage as RasterYuv420Semiplanar uv buffer pointer, coloredImage size area / 2)
		}
	}
	write: abstract func (pointer: Pointer, length: Int)
	start: abstract func (size: IntVector2D, format: String)
}
