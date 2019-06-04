use draw
use draw-gpu
use io
use geometry
use flow
use opengl

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
			case gpuMonochrome: OpenGLMonochrome =>
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
			case gpuRgba: OpenGLRgba =>
				rasterImage := gpuRgba toRaster()
				this _write(rasterImage)
				rasterImage referenceCount decrease()
			case rgbaImage: RasterRgba =>
				if (!this _started) {
					this _started = true
					this start(rgbaImage size, "rgba")
				}
				this write(rgbaImage buffer pointer, rgbaImage size area * rgbaImage bytesPerPixel)
			case =>
				Debug print("Unsupported Image type #{image class name} received by ${This class name}!")
		}
	}
	write: abstract func (pointer: Pointer, length: Int)
	start: abstract func (size: IntVector2D, format: String)
}
